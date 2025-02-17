(define (problem windfarm-mission-2)
    (:domain windfarm)

  ;  THE OBJECTS/TYPES ARE RENAMED FOR BETTER UNDERSTANDING.
  ;  {uuv1 - uuv} IS THE UNMANNED UNDERWATER VEHICLE (UUV).
  ;  {ship1 - ship} IS THE SHIP, WHICH IS ALSO THE INITIAL POSITION OF THE UUV.
  ;  {waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 - waypoint} ARE THE WAYPOINTS.
    (:objects
      uuv1 - uuv
      ship1 - ship
      waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 - waypoint
    )

  ;  THE WAYPOINTS FLOW.
  ;  THE INITIAL POSITION OF THE UUV STARTS FROM WAYPOINT1, WHICH IS THE SHIPS LOCATION.
  ;  WAYPOINT1 - WAYPOINT2
  ;  WAYPOINT2 - WAYPOINT3
  ;  WAYPOINT3 - WAYPOINT5
  ;  WAYPOINT5 - WAYPOINT1
  ;  WAYPOINT1 - WAYPOINT4
  ;  WAYPOINT4 - WAYPOINT3
  ;  A SAMPLE IS ALREADY AVAILABLE AT WAYPOINT1.
    (:init
      (at uuv1 waypoint1)                  
      (connected waypoint1 waypoint2)      
      (connected waypoint2 waypoint3)
      (connected waypoint3 waypoint5)
      (connected waypoint5 waypoint1)
      (connected waypoint1 waypoint4)
      (connected waypoint4 waypoint3)
      (sample_available waypoint1)         
    )

  ;  OUR GOAL
  ;  WE MUST CAPTURE THE IMAGE AT WAYPOINT5.
  ;  WE MUST PERFORM A SONAR SCAN AT THE WAYPOINT3.
  ;  THE UUV HAS COLLECTED THE SAMPLE FROM THE WAYPOINT1.
    (:goal
      (and
         (image_capture uuv1 waypoint5)   
         (scanned_sonar uuv1 waypoint3)   
         (sample_collected uuv1)                 
      )
   )
)
