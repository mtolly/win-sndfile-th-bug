This is a demonstration of a bug regarding `libsndfile` and Template Haskell on Windows, with GHC 8.0.1. GHC incorrectly attempts to use the static version of the library during Template Haskell, but only when the `libsndfile` dependency is in a separate package from the TH.

1. Clone this repo.

2. Install `stack`; I'm using 32-bit `stack` on 64-bit Windows 7.

3. From a dir that has a `stack.yaml` in it, `stack exec bash`, then `pacman -S mingw32/mingw-w64-i686-libsndfile`

4. Exit bash, then try to build `works` and `doesnt-work`. (`stack setup` first if needed)

```
C:\Users\Mike\git\win-sndfile-th-bug>cd works

C:\Users\Mike\git\win-sndfile-th-bug\works>stack build
the-pkg-0.1.0.0: configure
Configuring the-pkg-0.1.0.0...
the-pkg-0.1.0.0: build
Preprocessing executable 'the-pkg' for the-pkg-0.1.0.0...
[1 of 1] Compiling Main             ( src\Main.hs, .stack-work\dist\2fae85dd\build\the-pkg\the-pkg-tmp\Main.o )
Linking .stack-work\dist\2fae85dd\build\the-pkg\the-pkg.exe ...
the-pkg-0.1.0.0: copy/register
Installing executable(s) in
C:\Users\Mike\git\win-sndfile-th-bug\works\.stack-work\install\ecb21d6a\bin

C:\Users\Mike\git\win-sndfile-th-bug\works>cd ..\doesnt-work

C:\Users\Mike\git\win-sndfile-th-bug\doesnt-work>stack build
the-dep-0.1.0.0: configure
the-dep-0.1.0.0: build
the-dep-0.1.0.0: copy/register
the-pkg-0.1.0.0: configure
Configuring the-pkg-0.1.0.0...
the-pkg-0.1.0.0: build
Preprocessing executable 'the-pkg' for the-pkg-0.1.0.0...
[1 of 1] Compiling Main             ( src\Main.hs, .stack-work\dist\2fae85dd\build\the-pkg\the-pkg-tmp\Main.o )
ghc.exe: unable to load package `the-dep-0.1.0.0'
ghc.exe: C:\Users\Mike\AppData\Local\Programs\stack\i386-windows\msys2-20150512\mingw32\lib\libsndfile.a: unknown symbol `_FLAC__StreamDecoderErrorStatusString'


ghc.exe: Could not on-demand load symbol '_flac_open'

ghc.exe: C:\Users\Mike\AppData\Local\Programs\stack\i386-windows\msys2-20150512\mingw32\lib\libsndfile.a: unknown symbol `_flac_open'

ghc.exe: Could not on-demand load symbol '_sf_error_number'

ghc.exe: C:\Users\Mike\git\win-sndfile-th-bug\doesnt-work\.stack-work\install\ecb21d6a\lib\i386-windows-ghc-8.0.1\the-dep-0.1.0.0-AIVaSDrcVq78aqf7K5aad6\HSthe-dep-0.1.0.0-AIVaSDrcVq78aqf7K5aad6.o: unknown symbol `_sf_error_number'


--  While building package the-pkg-0.1.0.0 using:
      C:\Users\Mike\AppData\Roaming\stack\setup-exe-cache\i386-windows\setup-Simple-Cabal-1.24.0.0-ghc-8.0.1.exe --builddir=.stack-work\dist\2fae85dd build exe:the-pkg --ghc-options " -ddump-hi -ddump-to-file"
    Process exited with code: ExitFailure 1
Completed 2 action(s).

C:\Users\Mike\git\win-sndfile-th-bug\doesnt-work>
```

# How to fix

1. First find your `msys2` root. Mine was `C:\Users\Mike\AppData\Local\Programs\stack\i386-windows\msys2-20150512\mingw32\lib`

2. Under that root, copy all `.dll`s from `/mingw32/bin` to `/mingw32/lib`. Technically only the `libsndfile` dependencies are needed, but there are a lot of them.

3. Delete `/mingw32/lib/libsndfile.a`.

4. Rename `/mingw32/lib/libsndfile-1.dll` to `libsndfile.dll`.
