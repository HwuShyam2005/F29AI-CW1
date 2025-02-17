(define (domain windfarm)
    (:requirements :strips :typing)

    ; TYPES
    ;---------------------------------------------------------------------------
    
    ; THE THREE TYPES WE HAVE USED ARE ->
    ; uuv {THE UNMANNED UNDERWATER VEHICLE}
    ; ship {THE SHIP WHERE THE UNMANNED UNDERWATER VEHICLE (UUV) STARTS}
    ; waypoint {WAYPOINTS OR THE LOCATIONS PRESENT IN THE ENVIRONMENT}
    
    (:types
       uuv 
       ship       
       waypoint   
    )
    
    ; PREDICATES
    ;---------------------------------------------------------------------------
    (:predicates 
       (at ?u - uuv ?w - waypoint)           ; UUV IS PRESENT AT A SPECIFIC WAYPOINT.
       (image_capture ?u - uuv ?w - waypoint) ; UUV HAS NOTICED AND CAPTURED AN IMAGE AT THIS WAYPOINT.
       (scanned_sonar ?u - uuv ?w - waypoint) ; UUV THEN PERFORMS A SONAR SCAN AT THIS WAYPOINT.
       (connected ?w1 ?w2 - waypoint)        ; THESE TWO WAYPOINTS GET CONNECTED BY A PATH.
       (sample_collected ?u - uuv)                 ; UUV HAS COLLECTED A SAMPLE FOUND.
       (transmitted_data ?u - uuv ?s - ship) ; UUV THEN TRANSMITS THE FOUND DATA BACK TO THE SHIP.
       (sample_available ?w - waypoint)      ; A SAMPLE IS NOW AVAILABLE AT THE SPECIFIC WAYPOINT.
       (image_present ?u - uuv)                  ; UUV NOW HOLDS AN IMAGE.
       (scan_present ?u - uuv)                   ; UUV NOW HOLDS A SONAR SCAN.
       (has_deployed ?u - uuv)                   ; UUV HAS BEEN DEPLOYED.
    )

    ; ACTIONS
    ; --------------------------------------------------------------------------
    
    ; DEPLOYING THE UUV
    (:action uuv_deployed
        :parameters (?u - uuv ?w - waypoint)
        ; THE PRECONDITIONS WILL BE THAT ->
        ; UUV WILL START AT THE WAYPOINT1, WHICH WILL SHOW OR REPRESENT THE SHIP'S LOCATION.
        ; CURRENTLY THE UUV IS PRESENT AT THE SHIPS LOCATION.
        :precondition (and
            (at ?u waypoint1)           
            (has_deployed ?u)         
        )
        ; THE EFFECT WILL BE THAT ->
        ; UUV HAS BEEN CONSIDERED NOW AS DEPLOYED.
        ; UUV IS NO LONGER PRESENT AT THE WAYPOINT1.
        ; UUV IS NOW CONSIDERED TO BE PRESENT AT THE TARGET WAYPOINT.
        :effect (and
            (has_deployed ?u)               
            (not (at ?u waypoint1))      
            (at ?u ?w)                  
        )
    )
    ; --------------------------------------------------------------------------

    ; MOVING OF UUV BETWEEN THE CONNECTED WAYPOINTS
    (:action uuv_moved
        :parameters (?u - uuv ?w1 ?w2 - waypoint)
        ;  THE PRECONDITIONS WILL BE THAT ->
        ;  UUV IS PRESENT AT THE WAYPOINT1.
        ;   WAYPOINT1 ?W1 AND WAYPOINT2 ?W2 ARE CONNECTED.
        :precondition (and
            (at ?u ?w1)             
            (connected ?w1 ?w2)     
        )
        ; THE EFFECT WILL BE THAT ->
        ; UUV IS NO LONGER PRESENT AT ?W1
        ; IT WILL BE NOW PRESENT AT ?W2
        :effect (and
            (not (at ?u ?w1))       
            (at ?u ?w2)             
        )
    )
    ; --------------------------------------------------------------------------

    ; CAPTURING THE IMAGE AT THE SPECIFIC WAYPOINT
    (:action image_captured
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV IS PRESENT AT THE WAYPOINT.
    ;  UUV CURRENTLY HAS NO IMAGE TO BE STORED.
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (at ?u ?w)               
            (not (image_present ?u))      
        )
    ;  THE EFFECT WILL BE THAT ->
    ;  UUV HAS CAPTURED THE IMAGE AT THE WAYPOINT.
    ;  UUV NOW HAS AN IMAGE STORED IN THE MEMORY.
        :effect (and
            (image_capture ?u ?w)    
            (image_present ?u)            
        )
    )
    ; --------------------------------------------------------------------------

    ;  PERFORMING THE SONAR SCAN AT THE SPECIFIC WAYPOINT
    (:action sonar_scan_performed
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV IS PRESENT AT WAYPOINT.
    ;  WAYPOINT CURRENTLY HAS NO SONAR SCAN DATA STORED.
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (at ?u ?w)               
            (not (scan_present ?u))       
        )
    ;   THE EFFECT WILL BE THAT ->
    ;   UUV PERFORMS A SONAR SCAN AT THE WAYPOINT.
    ;   UUV NOW HAS A SONAR SCAN STORED IN ITS MEMORY.
        :effect (and
            (scanned_sonar ?u ?w)    
            (scan_present ?u)             
        )
    )
    ; --------------------------------------------------------------------------

    ; COLLECTING THE SAMPLE FROM A WAYPOINT
    (:action sample_collection
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV IS PRESENT AT WAYPOINT.
    ;  SAMPLE IS AVAILABLE AT THE WAYPOINT.
    ;  UUV CURRENTLY HAS NO SAMPLE STORED.
        :parameters (?u - uuv ?w - waypoint)
        :precondition (and
            (at ?u ?w)                
            (sample_available ?w)     
            (not (sample_collected ?u))     
        )
    ;  THE EFFECT WILL BE THAT ->
    ;  THE UUV NOW HAS A SAMPLE.
    ;  THE SAMPLE IS NO LONGER AVAILABLE AT THE WAYPOINT
        :effect (and
            (sample_collected ?u)           
            (not (sample_available ?w)) 
        )
    )
    ; --------------------------------------------------------------------------

    ; OFFLOADING THE SAMPLE BACK TO THE SHIP
    (:action sample_offloading
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV MUST BE PRESENT AT WAYPOINT AS ITS REPRESENTING THE SHIP.
    ;  UUV CURRENTLY HAS A SAMPLE STORED.
        :parameters (?u - uuv ?s - ship)
        :precondition (and
            (at ?u waypoint1)         
            (sample_collected ?u)           
        )
    ;  THE EFFECT WILL BE THAT ->
    ;  THE UUV WILL NO LONGER HAVE THE SAMPLE
        :effect (and
            (not (sample_collected ?u))      
        )
    )
    ; --------------------------------------------------------------------------
)