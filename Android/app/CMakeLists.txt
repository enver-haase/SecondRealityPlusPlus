cmake_minimum_required(VERSION 3.22)
project(SecondReality LANGUAGES C CXX)

get_filename_component(REPO_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../.." ABSOLUTE)

# SDLActivity loads libSDL3.so and libmain.so
set(SDL_SHARED ON CACHE BOOL "" FORCE)
set(SDL_STATIC OFF CACHE BOOL "" FORCE)
set(SDL_TEST_LIBRARY OFF CACHE BOOL "" FORCE)
set(SDL_CAMERA OFF CACHE BOOL "" FORCE)
add_subdirectory("${SDL3_DIR}" SDL3 EXCLUDE_FROM_ALL)

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
    "${REPO_ROOT}/Blob/*.c" "${REPO_ROOT}/Blob/*.cpp"
    "${REPO_ROOT}/Graphics/*.cpp"
    "${REPO_ROOT}/Music/*.cpp"
    "${REPO_ROOT}/Parts/*.c" "${REPO_ROOT}/Parts/*.cpp")

add_library(main SHARED "${REPO_ROOT}/main.cpp" ${SOURCES})

target_include_directories(main PRIVATE "${REPO_ROOT}")
target_compile_features(main PRIVATE cxx_std_20)
# optimized in debug builds too: unoptimized, the parts cannot keep up with the music;
# char is unsigned on Android/ARM, the DOS-era code expects it signed (e.g. VISU's animation deltas)
target_compile_options(main PRIVATE -O3 -fsigned-char -Wall -Wextra -Wno-missing-braces -Wno-unused-function)
target_link_libraries(main PRIVATE SDL3::SDL3-shared GLESv3 log android)
