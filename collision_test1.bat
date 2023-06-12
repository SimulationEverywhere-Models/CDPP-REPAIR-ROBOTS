copy collision_test1.val repair_robot.val
..\simu -mrepair_robot.ma -t00:00:00:400 -lcollision_test1.log
..\drawlog -mrepair_robot.ma -crepair_robot -lcollision_test1.log -f1 > collision_test1.drw
del repair_robot.val
