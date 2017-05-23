#!/bin/bash
systemctl enable NetworkManager.service && systemctl enable lxdm.service
# sed para autoeliminar el lanzador de este script en el rc local
rm Test2.bash
