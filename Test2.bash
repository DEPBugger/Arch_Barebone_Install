#!/bin/bash
systemctl enable NetworkManager.service && systemctl enable lxdm.service && systemctl start NetworkManager.service && systemctl start lxdm.service
# sed o rm para eliminar el lanzador de este script
rm $0
