copy collision_test3.val repair_robot.val
..\simu -mrepair_robot.ma -t00:00:00:500 -lcollision_test3.log
..\drawlog -mrepair_robot.ma -crepair_robot -lcollision_test3.log -f1 > collision_test3.drw
del repair_robot.val
