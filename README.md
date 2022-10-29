# Helper Scripts

go.ps1 - main script, copies git repo, makes cf stack, does everything basically

fullremove.ps1 - helper script to remove everything go.ps1 creates so you can rebuild

go-nogit.ps1 - helper script for development. assumes the source code of the project repo is in a folder called 'repo' and builds from that
