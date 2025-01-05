# Issues with using Ubuntu arm64

Current distro: `Linux ubuntu-21.10 6.11.0-13-generic #14-Ubuntu SMP PREEMPT_DYNAMIC Sun Dec  1 00:22:04 UTC 2024 aarch64 aarch64 aarch64 GNU/Linux`

openjdk 21 issues.

- Waiting for new updated `openjdk jre jdk` 
  ```
  openjdk-17-jdk-headless
  openjdk-17-jre
  jopenjdk-17-jre-headless
  ```
- [GoLand Workaround](https://youtrack.jetbrains.com/issue/JBR-8078/Bundled-JRE-crashes-on-M4-MacOS-15.2-in-virtualized-environments)
  - In `goland64.vmoptions, jetbrains_client64.vmoptions` added `-XX:UseSVE=0`

- Also could not run the `JetBrains ToolBox` since openjdk has issues with Ubutun 21.10


