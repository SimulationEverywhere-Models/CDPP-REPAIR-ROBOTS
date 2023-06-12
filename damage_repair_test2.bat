copy damage_repair_test2.val repair_robot.val
..\simu -mrepair_robot.ma -t00:00:10:000 -ldamage_repair_test2.log
..\drawlog -mrepair_robot.ma -crepair_robot -ldamage_repair_test2.log -f1 > damage_repair_test2.drw
del repair_robot.val
