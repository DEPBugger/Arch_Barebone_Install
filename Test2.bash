#!/bin/bash
systemctl enable NetworkManager.service && systemctl enable lxdm.service && systemctl start NetworkManager.service && systemctl start lxdm.service
# sed o rm para autoeliminar el lanzador de este script en el rc local
rm $0
