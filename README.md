# WEBP Encoder

### Description

This repo is an encoder for webp format. In a given directory it will look for all png/jpg/jpeg/etc images and create their mirrors in webp format. Useful for migrating a lot of images to webp in a simple way

This repository uses google webp encoder api.

### Use

1. Run `./install.sh`
2. Run `./img2webp.sh "DIRECTORY"`

**Notes:** 
- Only works for UNIX based systems. Still, it should be easy to port it to cygwin systems.
- If you want to customize the encoding, please open `img2webp.sh` and feel free to customize it as you please, its fairly simple.
