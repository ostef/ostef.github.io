Basic :: #import "Basic";
#import "Common";
Fenetres :: #import "Fenetres";
Fenetres_GL :: #import "Fenetres/GL";
#import "GL";
#import "Linalg";
Stylo :: #import "Stylo" (Origin_Top_Left = true);
#import "stb_image";

#load "localization.jai";

g_font_regular : *Stylo.Font;
g_font_bold : *Stylo.Font;
me : Stylo.TextureHandle;

Lang :: Language.French;

Scale :: 30.0;
Canvas_Width :: 21.0 * Scale;
Canvas_Height :: 29.7 * Scale;

Font_Big :: 0.9 * Scale;
Font_Medium :: 0.7 * Scale;
Font_Small :: 0.46 * Scale;

Background_Color :: Vec4f.{0.9,0.9,0.9,1};

Text_Color :: Vec4f.{0,0,0,1};
Text_Light_Color :: Vec4f.{0,0,0,1};
Text_Accent_Color :: Vec4f.{0,0,0,1};

Global_Margin :: 0.5 * Scale;

Image_Radius :: 2.5 * Scale;
Image_Margin :: Global_Margin * 2;

Left_Col_Width :: 0.35;  // Percent
Right_Col_Width :: 0.65;  // Percent

Left_Col :: Stylo.Rect.{
    Global_Margin,
    Global_Margin,
    Canvas_Width * Left_Col_Width - Global_Margin * 2,
    Canvas_Height - Global_Margin * 2
};

Right_Col :: Stylo.Rect.{
    Canvas_Width * Left_Col_Width + Global_Margin,
    Global_Margin,
    Canvas_Width * Right_Col_Width - Global_Margin * 2,
    Canvas_Height - Global_Margin * 2
};

Main_Rect_Top :: 3.0 * Scale;

Main_Rect :: Stylo.Rect.{
    Canvas_Width * Left_Col_Width + Global_Margin,
    Main_Rect_Top + Global_Margin,
    Canvas_Width * Right_Col_Width - Global_Margin * 2,
    Canvas_Height - Global_Margin * 2 - Main_Rect_Top
};

DrawLeftColumnText :: ()
{
    text_rect : Stylo.Rect;
    rect := Left_Col;
    Stylo.TruncateRect (*rect, 0, (Image_Radius + Image_Margin) * 2, 0, 0);

    text_rect = Stylo.PushFormattedText (
        Text_Contact_Info,
        xx Font_Small,
        rect,
        color = Text_Color,
        overflow = .Wrap
    );

    Stylo.TruncateRect (*rect, 0, text_rect.h + Global_Margin, 0, 0);

    text_rect = Stylo.PushFormattedText (
        Text_Address[Lang],
        xx Font_Small,
        rect,
        color = Text_Color,
        overflow = .Wrap
    );
}

DrawProjectEntry :: (rect : Stylo.Rect, project : Project) -> Stylo.Rect
{
    final_rect : Stylo.Rect;
    text_rect : Stylo.Rect;

    draw_rect := rect;

    text_rect = Stylo.PushFormattedText (
        project.name[Lang],
        xx Font_Small,
        draw_rect,
        color = Text_Color,
        overflow = .Wrap,
        font = g_font_bold
    );

    Stylo.TruncateRect (*draw_rect, 0, text_rect.h, 0, 0);

    text_rect = Stylo.PushFormattedText (
        project.subtitle[Lang],
        xx Font_Small,
        draw_rect,
        color = Text_Color,
        overflow = .Wrap,
    );

    return text_rect;
}

main :: ()
{
    window := Fenetres.CreateWindow (
        "Resume",
        cast (s32) Canvas_Width,
        cast (s32) Canvas_Height,
        flags = .No_Resize
    );
    defer Fenetres.DestroyWindow (window);

    gl_context := Fenetres_GL.CreateContext (window);
    defer Fenetres_GL.DestroyContext (gl_context);

    Fenetres_GL.MakeCurrent (window, gl_context);

    gl_load (*gl, Fenetres_GL.GetProcAddress);

    // Create framebuffer
    // Use framebuffer

    me = Stylo.LoadTexture ("../images/me.jpg");

    g_font_regular = Stylo.LoadFontFromFile ("C:/Windows/Fonts/segoeui.ttf");
    if !g_font_regular
    {
        LogError ("Could not load font segoeui.ttf");
        return;
    }

    Stylo.SetFont (g_font_regular);

    g_font_bold = Stylo.LoadFontFromFile ("C:/Windows/Fonts/segoeuib.ttf");
    if !g_font_bold
    {
        LogError ("Could not load font segoeuib.ttf");
        return;
    }

    quit := false;
    while !quit
    {
        for Fenetres.PollMessages ()
        {
            if it.kind == .Window_Closed
                quit = true;
        }

        viewport_w, viewport_h := Fenetres.GetViewportSize (window);

        glViewport (0, 0, xx viewport_w, xx viewport_h);
        glClearColor (Background_Color.r, Background_Color.g, Background_Color.b, Background_Color.a);
        glClear (GL_COLOR_BUFFER_BIT);

        Stylo.SetTexture (me);
        Stylo.PushCircle (.{Image_Radius + Image_Margin, Image_Radius + Image_Margin}, Image_Radius);
        Stylo.SetTexture (0);

        DrawLeftColumnText ();

        pen := Right_Col.position;
        text_rect : Stylo.Rect;

        text_rect = Stylo.PushFormattedText (
            "Stéfan Oumansour",
            xx Font_Big,
            Right_Col,
            color = Text_Color,
            align = .{0.5, 0},
            overflow = .Wrap,
            font = g_font_bold
        );

        pen.y += text_rect.h;

        text_rect = Stylo.PushFormattedText (
            Text_Student[Lang],
            xx Font_Medium,
            .{pen.x, pen.y, Right_Col.w, Right_Col.h - pen.y},
            color = Text_Color,
            align = .{0.5, 0},
            overflow = .Wrap
        );

        text_rect = Stylo.PushFormattedText (
            Text_Presentation[Lang],
            xx Font_Small,
            Main_Rect,
            color = Text_Color,
            overflow = .Wrap
        );

        rect := Stylo.TruncateRect (Main_Rect, 0, text_rect.h + 2 * Global_Margin, 0, 0);

        text_rect = DrawProjectEntry (rect, Projects[0]);

        Stylo.GLRenderDrawLists (viewport_w, viewport_h);
        Fenetres.SwapBuffers (window);

        Basic.sleep_milliseconds (30);
    }

    // Get framebuffer texture data
    // Write texture to disk
}
