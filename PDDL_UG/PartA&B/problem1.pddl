(define (problem windfarm-mission-1)
    (:domain windfarm)

  ;  THE OBJECTS/TYPES ARE RENAMED FOR BETTER UNDERSTANDING.
  ;  {uuv1 - uuv} IS THE UNMANNED UNDERWATER VEHICLE (UUV).
  ;  {ship1 - ship} IS THE SHIP, WHICH IS ALSO THE INITIAL POSITION OF THE UUV.
  ;  {waypoint1 waypoint2 waypoint3 waypoint4 - waypoint} ARE THE WAYPOINTS.
    (:objects
      uuv1 - uuv        
      ship1 - ship      
      waypoint1 waypoint2 waypoint3 waypoint4 - waypoint 
    )

  ;  THE WAYPOINTS FLOW.
  ;  THE INITIAL POSITION OF THE UUV STARTS FROM WAYPOINT1, WHICH IS THE SHIPS LOCATION.
  ;  WAYPOINT1 - WAYPOINT2
  ;  WAYPOINT2 - WAYPOINT1
  ;  WAYPOINT2 - WAYPOINT3
  ;  WAYPOINT3 - WAYPOINT4
  ;  WAYPOINT4 - WAYPOINT3
  ;  WAYPOINT4 - WAYPOINT1

    (:init
      (at uuv1 waypoint1)  
      (connected waypoint1 waypoint2)
      (connected waypoint2 waypoint1)      
      (connected waypoint2 waypoint3)
      (connected waypoint3 waypoint4)
      (connected waypoint4 waypoint3)
      (connected waypoint4 waypoint1)
  
  ;  WE CAN ADD INITIAL STATES FOR THE SAMPLES OR THE DATA, IF WE REQUIRE
  ;  FOR EXAMPLE, IF THE SAMPLE IS PRESENT AT WAYPOINT, WE CAN USE THE (sample_available waypoint)
  ;  WAYPOINT NUMBER MUST BE CHANGED ACCORDING TO THE LOCATION ITS PRESENT
    )
  
  ;  OUR GOAL
  ;  WE MUST CAPTURE THE IMAGE AT WAYPOINT3.
  ;  WE MUST PERFORM A SONAR SCAN AT THE WAYPOINT4.
    (:goal
      (and
         (image_capture uuv1 waypoint3)   
         (scanned_sonar uuv1 waypoint4)   
      )
   )
)
