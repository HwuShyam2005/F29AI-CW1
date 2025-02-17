(define (domain windfarm-1)
    (:requirements :strips :typing)

    ; TYPES
    ;---------------------------------------------------------------------------
    ; uuv {THE UNMANNED UNDERWATER VEHICLE}
    ; ship {THE SHIP WHERE THE UNMANNED UNDERWATER VEHICLE (UUV) STARTS}
    ; waypoint {WAYPOINTS OR THE LOCATIONS PRESENT IN THE ENVIRONMENT}
    ; engineer {RESPONSIBLE FOR THE DEPLOYMENTS AND THE DATA TRANSMISSIONS}
    ; location {MENTIONS THE SHIPS LOCATIONS [CONTROL CENTRE OR BAY]}
    (:types
       uuv        
       ship      
       waypoint   
       engineer   
       location   
    )

    ; PREDICATES
    ;---------------------------------------------------------------------------
    (:predicates 
       (at ?u - uuv ?w - waypoint)           ; UUV IS PRESENT AT A SPECIFIC WAYPOINT.
       (image_capture ?u - uuv ?w - waypoint) ; UUV HAS NOTICED AND CAPTURED AN IMAGE AT THIS WAYPOINT.
       (scanned_sonar ?u - uuv ?w - waypoint) ; UUV THEN PERFORMS A SONAR SCAN AT THIS WAYPOINT.
       (connected ?w1 ?w2 - waypoint)        ; THESE TWO WAYPOINTS GET CONNECTED BY A PATH.
       (sample_collected ?u - uuv)        ; UUV HAS COLLECTED A SAMPLE FOUND.          
       (transmitted_data ?u - uuv ?s - ship) ; UUV THEN TRANSMITS THE FOUND DATA BACK TO THE SHIP.
       (sample_available ?w - waypoint)      ; A SAMPLE IS NOW AVAILABLE AT THE SPECIFIC WAYPOINT.
       (image_present ?u - uuv)              ; UUV NOW HOLDS AN IMAGE.     
       (scan_present ?u - uuv)                   ; UUV NOW HOLDS A SONAR SCAN.
       (has_deployed ?u - uuv)                      ; UUV HAS BEEN DEPLOYED.
       (at_engineer ?e - engineer ?l - location) ; THE ENGINEER WILL BE ON EITHER OF THE SPECIFIED LOCATIONS [CONTROL CENTRE OR BAY]
    )

    ; ACTIONS
    ; --------------------------------------------------------------------------

    ; ENGINEER MOVES ON THE SHIP TO DIFFERENT LOCATIONS 
    (:action move_engineer
        :parameters (?e - engineer ?from - location ?to - location)
        ; THE PRECONDITIONS WILL BE THAT ->
        ; THE ENGINEER IS PRESENT AT FROM LOCATION.
        :precondition (at_engineer ?e ?from)
        ; THE POSTCONDITIONS WILL BE THAT ->
        ; THE ENGINEER IS NO MORE AT THE FROM LOCATION.
        ; THE ENGINEER IS NO AT TO LOCATION.
        :effect (and
            (not (at_engineer ?e ?from))
            (at_engineer ?e ?to)
        )
    )

    ; DEPLOYING THE UUV IF THE ENGINEER IS AT THE BAY
    (:action deploy_uuv
        :parameters (?u - uuv ?wstart - waypoint ?wend - waypoint ?e - engineer)
        ; THE PRECONDITIONS WILL BE THAT ->
        ; THE UUV STARTS AT THE SPECIFIC WAYPOINT (SHIP).
        ; ENGINEER MUST BE PRESENT AT THE BAY.
        ; THE UUV HAS NOT BEEN DEPLOYED YET.
        :precondition (and
            (at ?u ?wstart)           
            (at_engineer ?e bay)      
            (not (has_deployed ?u))       
        )
        ; THE POSTCONDITIONS WILL BE THAT ->
        ; THE UUV IS CONSIDERED DEPLOYED.
        ; UUV IS NO LONGER PRESENT AT THE STARTING WAYPOINT. 
        ; THE UUV IS NOW AT TARGET WAYPOINT
        :effect (and
            (has_deployed ?u)            
            (not (at ?u ?wstart))     
            (at ?u ?wend)             
        )
    )

    ; TRANSMITTING DATA IF THE ENGINEER IS AT THE CONTROL CENTRE
    (:action transmit_data
        :parameters (?u - uuv ?s - ship ?e - engineer)
        ; THE PRECONDITIONS WILL BE THAT ->
        ; ENGINEER IS PRESENT AT THE CONTROL CENTER
        ; UUV MUST CONSIST OF EITHER A SONAR DATA OR A IMAGE
        :precondition (and
            (at_engineer ?e control_centre)  
            (or (image_present ?u) (scan_present ?u)) 
        )
        ; THE POSTCONDITIONS WILL BE THAT ->
        ; THE UUV HAS TRANSMITTED THE DATA TO THE SHIP.
        ; IMAGE OR SONAR DATA IS CLEARED.
        :effect (and
            (transmitted_data ?u ?s)  
            (not (image_present ?u))      
            (not (scan_present ?u))       
        )
    )

    ; MOVING THE UUV IN BETWEEN THE CONNECTED WAYPOINTS
    (:action move
        :parameters (?u - uuv ?w1 ?w2 - waypoint)
        ; THE PRECONDITIONS WILL BE THAT ->
        ; THE UUV IS PRESENT AT THE FIRST WAYPOINT.
        ; THE SECOND WAYPOINT IS CONNECTED TO THE FIRST WAYPOINT. 
        :precondition (and
            (at ?u ?w1)             
            (connected ?w1 ?w2)     
        )
        ; THE POSTCONDITIONS WILL BE THAT ->
        ; THE UUV IS NO LONGER PRESENT AT THE FIRST WAYPOINT.
        ; THE UUV IS NOW PRESENT AT THE SECOND WAYPOINT.
        :effect (and
            (not (at ?u ?w1))       
            (at ?u ?w2)             
        )
    )

    ; CAPTURING THE IMAGE AT THE SPECIFIC WAYPOINT
    (:action capture_image
        :parameters (?u - uuv ?w - waypoint)
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV IS PRESENT AT THE WAYPOINT.
    ;  UUV CURRENTLY HAS NO IMAGE TO BE STORED.
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

    ;  PERFORMING THE SONAR SCAN AT THE SPECIFIC WAYPOINT
    (:action perform_sonar
        :parameters (?u - uuv ?w - waypoint)
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV IS PRESENT AT WAYPOINT.
    ;  WAYPOINT CURRENTLY HAS NO SONAR SCAN DATA STORED.
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

    ; COLLECTING THE SAMPLE FROM A WAYPOINT
    (:action collect_sample
        :parameters (?u - uuv ?w - waypoint)
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV IS PRESENT AT WAYPOINT.
    ;  SAMPLE IS AVAILABLE AT THE WAYPOINT.
    ;  UUV CURRENTLY HAS NO SAMPLE STORED.
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

; COLLECTING THE SAMPLE FROM A WAYPOINT
    (:action offload_sample
        :parameters (?u - uuv ?wship - waypoint)
    ;  THE PRECONDITIONS WILL BE THAT ->
    ;  UUV MUST BE PRESENT AT WAYPOINT AS ITS REPRESENTING THE SHIP.
    ;  UUV CURRENTLY HAS A SAMPLE STORED.
        :precondition (and
            (at ?u ?wship)         
            (sample_collected ?u)        
        )
    ;  THE EFFECT WILL BE THAT ->
    ;  THE UUV WILL NO LONGER HAVE THE SAMPLE
        :effect (and
            (not (sample_collected ?u))   
        )
    )
)