module vex

#flag linux -lSDL2
#flag linux -lSDL2_image
#flag linux -lGLEW
#flag linux -lGL
#flag linux  -I @VROOT/thirdparty/vex

#include "vex.h"

pub fn create_texture2d(path string) *Texture2D
{
    mut t := &Texture2D{ path: path }
    C.glGenTextures(1, &t.id)
    t.internal_format = u32(GL_RGB)
    t.image_format = u32(GL_RGB)
    t.wrap_s = u32(GL_REPEAT)
    t.wrap_t = u32(GL_REPEAT)
    t.filter_min = u32(GL_LINEAR)
    t.filter_mag = u32(GL_LINEAR)
    return t
}

pub fn(t &Texture2D) generate(width int, height int, data voidptr)
{
    t.width = u32(width)
    t.height = u32(height)
    C.glBindTexture(GL_TEXTURE_2D, t.id)
    C.glTexImage2D(GL_TEXTURE_2D, 0, t.internal_format, width, height, 0, t.image_format, GL_UNSIGNED_BYTE, data)
    C.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, t.wrap_s)
    C.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, t.wrap_t)
    C.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, t.filter_min)
    C.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, t.filter_mag)
    C.glBindTexture(GL_TEXTURE_2D, 0)
}

pub fn(t &Texture2D) bind()
{
    C.glBindTexture(GL_TEXTURE_2D, t.id)
}