#!/bin/bash
cd /workspaces/$(ls /workspaces | head -1)
git add .
git commit -m "Daily auto-backup $(date)" || true
git push || true
