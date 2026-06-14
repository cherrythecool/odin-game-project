@echo off
clang .\src\gles2.c -I .\include\ -O3 -Os -c -o .\lib\glad.lib