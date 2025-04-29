## Add SDK

ZoomSDK/windows/bin
ZoomSDK/windows/h
ZoomSDK/windows/lib

## Adjust CMakeLists

Add in windows/runner/CMakeLists.txt

```
add_custom_command(TARGET ${BINARY_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory
    "${CMAKE_SOURCE_DIR}/../ZoomSDK/windows/bin"
    "$<TARGET_FILE_DIR:${BINARY_NAME}>"
)
```
