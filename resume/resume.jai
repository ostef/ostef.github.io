#import "Common";
Fenetres :: #import "Fenetres";
Fenetres_GL :: #import "Fenetres/GL";
#import "GL";
#import "Linalg";
Stylo :: #import "Stylo" (Origin_Top_Left = true);
#import "stb_image";

#load "localization.jai";

me : Stylo.TextureHandle;

Lang :: Language.French;

Scale :: 30.0;
Canvas_Width :: 21.0 * Scale;
Canvas_Height :: 29.7 * Scale;

Font_Big :: 0.9 * Scale;
Font_Medium :: 0.7 * Scale;
Font_Small :: 0.5 * Scale;

Background_Color :: Vec4f.{0.9,0.9,0.9,1};

Text_Color :: Vec4f.{0,0,0,1};
Text_Light_Color :: Vec4f.{0,0,0,1};
Text_Accent_Color :: Vec4f.{0,0,0,1};

Global_Margin :: 0.5 * Scale;

Image_Radius :: 2.5 * Scale;
Image_Margin :: Global_Margin * 2;

Left_Col_Width :: 0.4;  // Percent
Right_Col_Width :: 0.6;  // Percent

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

LoadTexture :: ($filename : string) -> Stylo.TextureHandle #must
{
    w, h : s32;
    data := stbi_load (filename, *w, *h, null, 4);
    if !data
        return 0;

    defer stbi_image_free (data);

    return Stylo.CreateTexture (xx w, xx h, data);
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

    me = LoadTexture ("../images/me.jpg");

    font := Stylo.LoadFontFromFile ("C:/Windows/Fonts/segoeui.ttf");
    if !font
    {
        LogError ("Could not load font segoeui.ttf");
        return;
    }

    Stylo.SetFont (font);
    page := Stylo.LoadFontPage (font, 22);

    quit := false;
    while !quit
    {
        Stylo.SetTexture (me);
        Stylo.PushCircle (.{Image_Radius + Image_Margin, Image_Radius + Image_Margin}, Image_Radius);
        Stylo.SetTexture (0);

        for Fenetres.PollMessages ()
        {
            if it.kind == .Window_Closed
                quit = true;
        }

        viewport_w, viewport_h := Fenetres.GetViewportSize (window);

        glViewport (0, 0, xx viewport_w, xx viewport_h);
        glClearColor (Background_Color.r, Background_Color.g, Background_Color.b, Background_Color.a);
        glClear (GL_COLOR_BUFFER_BIT);

        pen := Right_Col.position;
        text_rect : Stylo.Rect;

        text_rect = Stylo.PushFormattedText (
            "Stéfan Oumansour",
            xx Font_Big,
            Right_Col,
            color = Text_Color,
            align = .{0.5, 0},
            overflow = .Wrap
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

        Stylo.GLRenderDrawLists (viewport_w, viewport_h);
        Fenetres.SwapBuffers (window);
    }

    // Get framebuffer texture data
    // Write texture to disk
}
