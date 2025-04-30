## Add SDK

ZoomSDK/windows/bin
ZoomSDK/windows/h
ZoomSDK/windows/lib

## Configure Zoom SDK Path

You have several options to configure the path to your Zoom SDK:

1. **Environment Variable**: Set the `ZOOM_SDK_PATH` environment variable to your Zoom SDK directory

   ```
   set ZOOM_SDK_PATH=C:\path\to\your\ZoomSDK\windows
   ```

2. **CMake Variable**: When running CMake, specify the path with the `-DZOOM_SDK_DIR` parameter

   ```
   cmake -DZOOM_SDK_DIR=C:/path/to/your/ZoomSDK/windows ...
   ```

3. **Default Path**: If no path is specified, the plugin will look for the SDK in
   `your_app/example/ZoomSDK/windows/`

## Adjust CMakeLists

Add in windows/runner/CMakeLists.txt

```
add_custom_command(TARGET ${BINARY_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_SOURCE_DIR}/../ZoomSDK/windows/bin"
    "$<TARGET_FILE_DIR:${BINARY_NAME}>"
)
```
