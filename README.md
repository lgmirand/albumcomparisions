# albumcomparisions
Python + R project to identify and visualize differences between The 1975's oldest album (The 1975) and most recent album (A Brief Inquiry into Online Relationships).

For these two albums in particular, the top three most distinguishing variables were:
  - energy
  - time signature
  - liveness

The python code is set up to run through with little user input. The user must specify the artist and then choose two albums of the artist to compare. From there, the code pulls from the API and formats into the proper structure for analysis.

The R code is requires more user interaction. Users must choose which variables to leave into the model. The choice of logistic regression with the lasso penalty was to fit explainability goals as well as account for a small subset of data. The data was not split into train and test because the point of the model is just to explain differences and not to predict or model on any other album, making the data going into the system the population data. To compare a different set of albums, a user must re-run the code specific to the album.

Moving forward, I would like to look more into the visualization aspect of this piece. Given the one week time constraint of the project I was not able to go further into that very important piece, which would be useful if this was deployed as an application in the future.
