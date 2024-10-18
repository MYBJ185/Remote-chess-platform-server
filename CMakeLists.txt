cmake_minimum_required(VERSION 3.16)
project(GZDServer)

set(CMAKE_CXX_STANDARD 17)

# 检查是否在本地开发环境
if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    # 本地项目使用独立的 vcpkg 工具链
    set(VCPKG_ROOT "${CMAKE_SOURCE_DIR}/vcpkg")
    set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")

    # 打印 vcpkg 路径用于调试
    message(STATUS "Using local vcpkg toolchain: ${CMAKE_TOOLCHAIN_FILE}")

elseif (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    # Ubuntu 服务器上使用系统级 vcpkg
    set(CMAKE_TOOLCHAIN_FILE "/usr/local/vcpkg/scripts/buildsystems/vcpkg.cmake")

    # 打印 vcpkg 路径用于调试
    message(STATUS "Using system vcpkg toolchain: ${CMAKE_TOOLCHAIN_FILE}")

endif()

# 查找并使用 Boost 库
find_package(Boost REQUIRED COMPONENTS system filesystem)

if (Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS})
    target_link_libraries(GZDServer ${Boost_LIBRARIES})
else()
    message(FATAL_ERROR "Boost not found!")
endif()

# 添加可执行文件
add_executable(GZDServer main.cpp)
