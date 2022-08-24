#  Cocktails
## My solution to a take home assignment I was given as a step of an interview process for an iOS developer role.

### The task
I was asked to write a simple application to display cocktail recipes from a database, using two different API endpoints.
The application was to have two screens:
One main screen built with UIKit, showing a list of the cocktails with the name and associated image for each one.
One details screen built with SwiftUI, showing the details of the selected cocktail. Must include image, name, glassware, instructions and ingredients with measurements.

#### Requirements:
- One week to finish
- No 3rd party frameworks
- Deployment target iOS 15
- They must be able to build and run the project with the lates stabel version of Xcode

#### Example API responses:

##### /cocktails/

    [ 
        {
            "id": "12560",
            "name": "Afterglow",
            "imageUrl": "https://www.thecocktaildb.com/images/media/drink/vuquyv1468876052.jpg"
        }, 
        {
            "id": "12562",
            "name": "Alice Cocktail",
            "imageUrl": "https://www.thecocktaildb.com/images/media/drink/qyqtpv1468876144.jpg"
        }, 
        {
            "id": "12862",
            "name": "Aloha Fruit punch",
            "imageUrl": "https://www.thecocktaildb.com/images/media/drink/wsyvrt1468876267.jpg"
        } 
    ]
    
##### /cocktails/{cocktail-id}

    {
        "id": "12560",
        "name": "Afterglow",
        "imageUrl": "https://www.thecocktaildb.com/images/media/drink/vuquyv1468876052.jpg",
        "glass": "Highball Glass",
        "instructions": "Mix. Serve over ice.",
        "ingredients": [
            {
                "name": "Grenadine",
                "measure": "1 part "
            }, 
            {
                "name": "Orange juice",
                "measure": "4 parts "
            },
            {
                "name": "Pineapple juice",
                "measure": "4 parts "
            } 
        ]
    }

### I was asked to explain my decisions in a README file, this is what I wrote

I chose to use MVC architecture for the UIKit part and MVVM architecture for the SwiftUI part.
I prefer MVVM but have not used it with UIKit before. If I were to use MVVM with UIKit I would probably leverage the Combine framework.

The network layer is one I built for a project I'm currently working on. I used it both to show you I can make a more complex, abstracted network layer and to save time.

My strategy was to start with the basic functionality - make sure I could load the cocktails, make the list screen and detail views. After that I added to and iterated on the code with the time I had left of the estimated 4 hours.
