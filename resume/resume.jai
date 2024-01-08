#import "Basic";
#import "Math";

Fenetres :: #import "Fenetres";
Fenetres_GL :: #import "Fenetres/GL";

#import "GL";

Stylo :: #import "Stylo" (Origin_Top_Left = true);

#import "stb_image";
#import "stb_image_write";

#load "localization.jai";

Vec2f :: Vector2;
Vec4f :: Vector4;

g_draw_list : Stylo.DrawCommandList;
g_font_regular : *Stylo.Font;
g_font_bold : *Stylo.Font;
g_font_italic : *Stylo.Font;
g_font_bold_italic : *Stylo.Font;
me : Stylo.TextureHandle;

g_lang := Language.French;

Default_Scale :: 32.0;

Scale : float;
Canvas_Width, Canvas_Height : float;

Font_Big, Font_Medium, Font_Small : float;

Background_Color :: Vec4f.{0.98,0.98,0.98,1};

Text_Color :: Vec4f.{0,0,0,1};
Text_Light_Color :: Vec4f.{0.451, 0.451, 0.451,1};
Text_Accent2_Color :: Vec4f.{0.176, 0.42, 0.6,1};
Text_Accent_Color :: Vec4f.{0, 0.29, 0.678,1};

Global_Margin : float;

Image_Radius : float;
// Make it centered in the left column
Image_Margin : float;

Left_Col_Width :: 0.3;  // Percent
Right_Col_Width :: 1.0 - Left_Col_Width;  // Percent

Left_Col : Stylo.Rect;
Right_Col : Stylo.Rect;

Main_Rect_Top : float;

Main_Rect : Stylo.Rect;

Header_Indent : float;

Project_Date_Width :: 0.07; // Percent;

SetScale :: (scale : float)
{
    Scale = scale;
    Canvas_Width = 21.0 * Scale;
    Canvas_Height = 29.7 * Scale;

    Font_Big = 0.7 * Scale;
    Font_Medium = 0.54 * Scale;
    Font_Small = 0.367 * Scale;
    Global_Margin = 0.3 * Scale;

    Image_Radius = 2.2 * Scale;
    // Make it centered in the left column
    Image_Margin = (Canvas_Width * Left_Col_Width - Image_Radius * 2) * 0.5;

    Left_Col = Stylo.Rect.{
        Global_Margin,
        Global_Margin,
        Canvas_Width * Left_Col_Width - Global_Margin * 2,
        Canvas_Height - Global_Margin * 2
    };

    Right_Col = Stylo.Rect.{
        Canvas_Width * Left_Col_Width + Global_Margin,
        Global_Margin,
        Canvas_Width * Right_Col_Width - Global_Margin * 2,
        Canvas_Height - Global_Margin * 2
    };

    Main_Rect_Top = 2.4 * Scale;

    Main_Rect = Stylo.Rect.{
        Canvas_Width * Left_Col_Width + Global_Margin,
        Main_Rect_Top + Global_Margin,
        Canvas_Width * Right_Col_Width - Global_Margin * 2,
        Canvas_Height - Global_Margin * 2 - Main_Rect_Top
    };

    Header_Indent = 0.01 * Canvas_Width;
}

DrawHeader :: inline (text : string, rect : Stylo.Rect) -> Stylo.Rect
{
    return Stylo.PushText (
        *g_draw_list,
        g_font_bold_italic,
        text,
        xx Font_Medium,
        Stylo.TruncateRect (rect, left = Header_Indent),
        color = Text_Accent_Color
    );
}

DrawLeftColumnText :: (top : float)
{
    Link :: (rect : Stylo.Rect, name : string, link : string) -> Stylo.Rect
    {
        text_rect := Stylo.PushText (
            *g_draw_list,
            g_font_bold,
            name,
            xx Font_Small,
            rect,
            color = Text_Color,
            overflow = .Wrap_Word
        );

        Stylo.TruncateRect (*rect, top = text_rect.h);

        text_rect = Stylo.PushText (
            *g_draw_list,
            g_font_regular,
            link,
            xx Font_Small,
            rect,
            color = Text_Color,
            overflow = .Wrap_Word
        );

        return text_rect;
    }

    text_rect : Stylo.Rect;
    rect := Left_Col;
    Stylo.TruncateRect (*rect, top = top - rect.y);

    text_rect = DrawHeader (Text_Contact_Info_Header[g_lang], rect);
    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

    text_rect = Stylo.PushText (
        *g_draw_list,
        g_font_regular,
        Text_Contact_Info,
        xx Font_Small,
        rect,
        color = Text_Color,
        overflow = .Wrap_Word
    );

    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

    text_rect = Link (rect, "Linkedin", "https://www.linkedin.com/in/stefan-oumansour");

    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);
    text_rect = Link (rect, "GitHub", "https://github.com/ostef");

    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);
    text_rect = Link (rect, "Portfolio", "https://ostef.github.io");

    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin * 1.5);

    text_rect = DrawHeader (Text_Languages_Header[g_lang], rect);
    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

    text_rect = Stylo.PushText (
        *g_draw_list,
        g_font_regular,
        Text_Languages[g_lang],
        xx Font_Small,
        rect,
        color = Text_Color,
        overflow = .Wrap_Word
    );

    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin * 1.5);

    text_rect = DrawHeader ("Soft Skills", rect);
    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

    text_rect = Stylo.PushText (
        *g_draw_list,
        g_font_regular,
        Text_Soft_Skills[g_lang],
        xx Font_Small,
        rect,
        color = Text_Color,
        overflow = .Wrap_Word
    );

    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin * 1.5);

    text_rect = DrawHeader (Text_Interests_Header[g_lang], rect);
    Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

    text_rect = Stylo.PushText (
        *g_draw_list,
        g_font_regular,
        Text_Interests[g_lang],
        xx Font_Small,
        rect,
        color = Text_Color,
        overflow = .Wrap_Word
    );
}

DrawProjectEntry :: (rect : Stylo.Rect, project : Project) -> Stylo.Rect
{
    dates_rect := Stylo.Rect.{rect.x, rect.y, Project_Date_Width * Canvas_Width, rect.h};
    Stylo.PushText (
        *g_draw_list,
        g_font_italic,
        project.dates[g_lang],
        xx Font_Small,
        dates_rect,
        color = Text_Light_Color,
        overflow = .Wrap_Word
    );

    draw_rect := Stylo.TruncateRect (rect, left = dates_rect.w + Global_Margin);
    final_rect : Stylo.Rect;
    text_rect : Stylo.Rect;

    text_rect = Stylo.PushText (
        *g_draw_list,
        g_font_bold,
        project.name[g_lang],
        xx Font_Small,
        draw_rect,
        color = Text_Color,
        overflow = .Wrap_Word
    );

    final_rect = text_rect;

    Stylo.TruncateRect (*draw_rect, 0, text_rect.h, 0, 0);

    text_rect = Stylo.PushText (
        *g_draw_list,
        g_font_regular,
        project.description[g_lang],
        xx Font_Small,
        draw_rect,
        color = Text_Color,
        overflow = .Wrap_Word
    );

    final_rect.h += text_rect.h;

    return final_rect;
}

main :: ()
{
    next_is_scale : bool;
    args := get_command_line_arguments ();
    for args
    {
        if next_is_scale
        {
            result, ok := string_to_float (it);
            if !ok
            {
                log_error ("Error: expected float value for -scale");
                return;
            }

            SetScale (floor (result));
            next_is_scale = false;
        }
        else if it ==
        {
        case "-fr";
            g_lang = .French;
        case "-en";
            g_lang = .English;
        case "-scale";
            next_is_scale = true;
        }
    }

    if Scale <= 0
        SetScale (floor (Default_Scale));

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

    g_font_regular = Stylo.LoadFontFromFile ("OpenSans-Regular.ttf");
    if !g_font_regular
    {
        log_error ("Could not load font OpenSans-Regular.ttf");
        return;
    }

    g_font_bold = Stylo.LoadFontFromFile ("OpenSans-Bold.ttf");
    if !g_font_bold
    {
        log_error ("Could not load font OpenSans-Bold.ttf");
        return;
    }

    g_font_italic = Stylo.LoadFontFromFile ("OpenSans-Italic.ttf");
    if !g_font_bold
    {
        log_error ("Could not load font OpenSans-Italic.ttf");
        return;
    }

    g_font_bold_italic = Stylo.LoadFontFromFile ("OpenSans-BoldItalic.ttf");
    if !g_font_bold
    {
        log_error ("Could not load font OpenSans-BoldItalic.ttf");
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
        glClearColor (Background_Color.x, Background_Color.y, Background_Color.z, Background_Color.w);
        glClear (GL_COLOR_BUFFER_BIT);

        Stylo.SetTexture (*g_draw_list, me);
        Stylo.PushCircle (*g_draw_list, .{Image_Radius + Image_Margin, Image_Radius + Image_Margin}, Image_Radius);
        Stylo.SetTexture (*g_draw_list, 0);

        text_rect : Stylo.Rect;

        text_rect = Stylo.PushText (
            *g_draw_list,
            g_font_bold,
            "Stéfan OUMANSOUR",
            xx Font_Big,
            Right_Col,
            color = Text_Accent_Color,
            overflow = .Wrap_Word,
        );

        text_rect = Stylo.PushText (
            *g_draw_list,
            g_font_regular,
            Text_Student[g_lang],
            xx Font_Medium,
            Stylo.TruncateRect (Right_Col, top = text_rect.h),
            color = Text_Accent2_Color,
        );

        rect := Main_Rect;

        text_rect = Stylo.PushText (
            *g_draw_list,
            g_font_regular,
            Text_Presentation[g_lang],
            xx Font_Small,
            Main_Rect,
            color = Text_Color,
            overflow = .Wrap_Word
        );

        Stylo.TruncateRect (*rect, top = text_rect.h + 1.5 * Global_Margin);

        DrawLeftColumnText (rect.y);

        text_rect = DrawHeader (Text_Projects_Header[g_lang], rect);
        Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

        for Projects
        {
            if it_index != 0
                Stylo.TruncateRect (*rect, top = text_rect.h + 0.7 * Global_Margin);
            text_rect = DrawProjectEntry (rect, it);
        }

        Stylo.TruncateRect (*rect, top = text_rect.h + 1.5 * Global_Margin);

        text_rect = DrawHeader (Text_Education_Header[g_lang], rect);
        Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

        dates_rect := rect;
        dates_width : float;
        for Education
        {
            text_rect := Stylo.PushText (
                *g_draw_list,
                g_font_italic,
                it.dates[g_lang],
                xx Font_Small,
                dates_rect,
                color = Text_Light_Color,
                overflow = .None,
            );

            Stylo.TruncateRect (*dates_rect, top = text_rect.h);

            dates_width = max (dates_width, text_rect.w);
        }

        for Education
        {
            if it_index != 0
                Stylo.TruncateRect (*rect, top = text_rect.h);

            text_rect = Stylo.PushText (
                *g_draw_list,
                g_font_italic,
                it.text[g_lang],
                xx Font_Small,
                Stylo.TruncateRect (rect, left = dates_width + Global_Margin),
                color = Text_Color,
                overflow = .None
            );
        }

        Stylo.TruncateRect (*rect, top = text_rect.h + 1.5 * Global_Margin);

        DrawHeader (Text_Technical_Skills_Header[g_lang], rect);
        Stylo.TruncateRect (*rect, top = text_rect.h + Global_Margin);

        text_rect = Stylo.PushText (
            *g_draw_list,
            g_font_italic,
            Text_Technical_Skills_General[g_lang],
            xx Font_Small,
            rect,
            color = Text_Color,
            overflow = .None
        );

        Stylo.TruncateRect (*rect, left = text_rect.w + 3 * Global_Margin);

        text_rect = Stylo.PushText (
            *g_draw_list,
            g_font_italic,
            Text_Technical_Skills_Languages[g_lang],
            xx Font_Small,
            rect,
            color = Text_Color,
            overflow = .None
        );

        Stylo.TruncateRect (*rect, left = text_rect.w + 3 * Global_Margin);

        text_rect = Stylo.PushText (
            *g_draw_list,
            g_font_italic,
            Text_Technical_Skills_Other,
            xx Font_Small,
            rect,
            color = Text_Color,
            overflow = .None
        );

        Stylo.GLRenderCommandLists (*g_draw_list, viewport_w, viewport_h);

        Fenetres.SwapBuffers (window);

        sleep_milliseconds (30);
    }

    // Get framebuffer texture data
    // Write texture to disk
}
