cavppers
========
Scripts to facilitate the digitization and digital preservation workflow of audio and video files at the California Audiovisual Preservation Project.

## To install all microservices:
Homebrew should already be installed.

In the command line type: 
 - `brew tap cavpp/cavpp`
 - `brew update`
 - `brew install cavppers`
 
To update after a new release:
 - `brew update`
 - `brew upgrade`

If this doesn’t work remove and reinstall: 
 - `brew rm cavppers`
 - `brew install cavppers`


## pbcorethat

### about

`pbcorethat` is intended for specific CAVPP workflow and requires a very specific input: a directory which contains CAVPP packages and a single inventory csv. The inventory is anticipated to be a CAVPP-formatted inventory list with a specific alignment of metadata values to column number. If more than one csv is present within the directory then only the first one found will be used.

### dependencies
`pbcorethat` requires:
- `csvprintf`
- `mediainfo`
- `xmlstarlet`

If using homebrew this can be installed with:
`brew install csvprintf mediainfo xmlstarlet`

### To use: 
- Export AV Data Export CSV from islandora 
- Entire partner collection is fine. Script will find and only make PBCore for IDs with matching files. 
- Save export in folder named with MARC ID.  
- This MARC ID folder should also contain folders named with ObjectIDs. ObjectID folders should contain all files for each object (prsv, access, and .md5s) 
- In Terminal type: `pbcorethat`[drag in path to MARC ID folder] 
- Script should run and generate pbcore within ObjectID folders.


