# Users
## stores info about users. 
    User:
        UID -> String (KEY)
            First Name -> String
            Last Name -> String
        
### Example:
    {
     "User": {
                *"UID": "EUPd4mXjLXPWvolY3PnjppK7JyN2"
                "First Name": "Amir
                "Last Name": "Mostafavi""
            }
    }


# Records
## stores info about responses.
    UID -> String
        ImageID -> String
            Responses -> [Int8]
            
### Example:          
    {
        "Records": {
                *"UID": "EUPd4mXjLXPWvolY3PnjppK7JyN2"
                "Responses": [a12b1000: [1, -1, 0]]
        }
    }
            
            

