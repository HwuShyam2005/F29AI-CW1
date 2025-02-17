(define (problem windfarm-mission-3)
    (:domain windfarm)

  ;  THE OBJECTS/TYPES ARE RENAMED FOR BETTER UNDERSTANDING.
  ;  {uuv1 uuv2 - uuv} IS THE UNMANNED UNDERWATER VEHICLE (UUV).
  ;  {ship1 ship2 - ship} IS THE SHIP, WHICH IS ALSO THE INITIAL POSITION OF THE UUV.
  ;  {waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 waypoint6 - waypoint} ARE THE WAYPOINTS.
    (:objects
      uuv1 uuv2 - uuv
      ship1 ship2 - ship
      waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 waypoint6 - waypoint
    )

  ;  THE WAYPOINTS FLOW.
  ;  THE UUV1 STARTS AT THE WAYPOINT2.
  ;  THE UUV2 STARTS AT THE WAYPOINT4. NOW THIS REPRESENTS THE SHIP2'S LOCATION
  ;  WAYPOINT1 - WAYPOINT2
  ;  WAYPOINT2 - WAYPOINT1
  ;  WAYPOINT2 - WAYPOINT3
  ;  WAYPOINT2 - WAYPOINT4
  ;  WAYPOINT4 - WAYPOINT2
  ;  WAYPOINT3 - WAYPOINT5
  ;  WAYPOINT5 - WAYPOINT3
  ;  WAYPOINT5 - WAYPOINT6
  ;  WAYPOINT6 - WAYPOINT4
  ;  A SAMPLE IS AVAILABLE AT WAYPOINT1 FOR UUV1.
  ;  A SAMPLE IS AVAILABLE AT WAYPOINT5 FOR UUV2.
    (:init
      (at uuv1 waypoint2)                   
      (at uuv2 waypoint4)                   
      (connected waypoint1 waypoint2)       
      (connected waypoint2 waypoint1)
      (connected waypoint2 waypoint3)
      (connected waypoint2 waypoint4)
      (connected waypoint4 waypoint2)
      (connected waypoint3 waypoint5)
      (connected waypoint5 waypoint3)
      (connected waypoint5 waypoint6)
      (connected waypoint6 waypoint4)
      (sample_available waypoint1)          
      (sample_available waypoint5)          
    )

  ;  OUR GOAL
  ;  FOR UUV1
  ;  IMAGE MUST BE CAPTURED AT WAYPOINT2.
  ;  SONAR SCAN MUST BE PERFORMED AT WAYPOINT4.
  ;  SAMPLE MUST BE COLLECTED AT WAYPOINT1.
    (:goal
      (and
         (image_capture uuv1 waypoint2)    
         (scanned_sonar uuv1 waypoint4)    
         (sample_collected uuv1)                  

  ;FOR UUV2
  ;  IMAGE MUST BE CAPTURED AT WAYPOINT3.
  ;  SONAR SCAN MUST BE PERFORMED AT WAYPOINT6.
  ;  SAMPLE MUST BE COLLECTED AT WAYPOINT5.
         (image_capture uuv2 waypoint3)   
         (scanned_sonar uuv2 waypoint6)    
         (sample_collected uuv2)                  
      )
   )
)
