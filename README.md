# Team 24 - Buckle Up

## Introduction
Buckle Up is the app to help users manage their checklists for travelling. The main function of our app is, users can create the trip, and Buckle Up will automatically generated checklists, classified by clothes, toiletries, electronics and accessories, according to the weather condition of the destination. And users can add, delete or change the items in the checklists basesd on our recommendations.

## Functionalities
### Login Page
![Imgur](https://i.imgur.com/7Exvqvfl.png)  
As Sign Up is not the feature included in version 2 deliverables, thus we do not test it a lot. We strongly encourge you to use our account for grading. (User name: Test, Password： 123456)

### Trip Page
![Imgur](https://i.imgur.com/dNoGrq1l.png)  
Users can view trips or create trips

### Create Trip
![Imgur](https://i.imgur.com/3PAhCDNl.png)  
To create the trip, it will start from this page, asking for location, **We recommend to type in famous cities(Pittsburgh, Boston, Shanghai, Beijing, Seoul, tec.) just to make sure the api we use has that data**, then choose start date and end date, after users select end date, **it will jump back to the location page, but the trip has already been created, just click on back.**

### Outfit View
![Imgur](https://i.imgur.com/kwVX4c7l.png)  
In this page, Buckle Up automatically generate basic clothes for users, users can switch date by clicking on top navigation bar, users can also edit the name of clothes, add new clothes or delete clothes, by clicking on **"edit"**, to edit clothes, just click on the name of clothes, to add new clothes, click on add item button, to delete clothes, long press on the row and swipe. please make sure to **click on done to save changes.**

### Checklist View
![Imgur](https://i.imgur.com/5P1d2rPl.png)![Imgur](https://i.imgur.com/4hf86tOl.png)  
In this page, users can find other items we recommend to bring with, users can also add, delete and change items.  
  
For this page, we only allow users to change toiletries, electronics and accessories. Cause the changes of clothes are made on Outfit View, this view only allow users to check whether bring clothes or not.  
  
To edit items, please also click on **"edit"**, the operations are the same with those in outfit view.  

### Features that we may remove in version2
At first we plan to add a circle to give users an idea of how many items he/she has already checked. To implement this function, we tried over 2 days, but we still got some bugs. As data need to be passed through multiple views and two repositories, the firebase keeps refreshing, which leads to our UI keeps refreshing too, there might be some deadlocks currently we cannot solve.  
  
We tries several ways to implement this:  
We directly add this feature as one attricutes in our model, and try to update the value each time users checked or unchecked items, but this leads to deadlocks. We suppose it's because the sub class calls the function in its parent class.  
  
Then we came up with the idea, create a new model to save the data, thus we do need to pass data through two repositories, but this also failed. Then we thought passing values through two repositories maybe a little bit complex.  
  
Next we choose to calculate this value every time users launch the app, and do not save this value into firestore. But this also failed.  
  
  
Then we had a meeting to discuss if this feature is necessary, two of our team members did some user survey again. And over 70% percentage of users said, they are not interested in this feature, as they will check the checklists again before they leave, even they know they have already checked the list. Also, showing the percentage is meaningless to them, from the user survey results, we learn that for users, there are only two numbers that maybe meaningful to them, one is 0% and the other is 100%, any percentage between 0 and 100 means the same: they haven't packed all the things they will bring.  
  
Due to the techinal blockers and our user survuy results, we may want to remove this feature in our final version.
