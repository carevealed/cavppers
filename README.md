cavppers
========
Scripts to facilitate the digitization and digital preservation workflow of audio and video files at the California Audiovisual Preservation Project.

## pbcorethat

### about

`pbcorethat` is intended for specific CAVPP workflow and requires the a very specific input: a directory which contains CAVPP packages and a single inventory csv. The inventory is anticipated to be a CAVPP-formatted inventory list with a specific alignment of metadata values to column number. If more than one csv is present within the directory then only the first one found will be used.

### dependencies
`pbcorethat` requires:
- `csvprintf`
- `mediainfo`
- `xmlstarlet`

If using homebrew this can be installed with:
`brew install csvprintf mediainfo xmlstarlet`

