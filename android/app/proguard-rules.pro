# Keep Error Prone annotations (recommended to avoid runtime issues)
-keep class com.google.errorprone.annotations.** { *; }

# Keep javax.annotation annotations (recommended to avoid runtime issues)
-keep class javax.annotation.** { *; }

# Suppress warnings for missing classes (if you still want to do this)
-dontwarn com.google.errorprone.annotations.CanIgnoreReturnValue
-dontwarn com.google.errorprone.annotations.CheckReturnValue
-dontwarn com.google.errorprone.annotations.Immutable
-dontwarn com.google.errorprone.annotations.RestrictedApi
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy
