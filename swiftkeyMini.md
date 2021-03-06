Swiftkey Mini Application - Data Science Capstone Course Project
========================================================
author: Vasudevan Durairaj
date: 10/August/2018
autosize: true



About the Swiftkey Mini Application
========================================================
width: 940
height: 529
This Shiny Application was built to predict the next word with inputs from the Swiftkey test data set, similar to the predictive text functions found on today's modern smart phones. 

## Taks Performed for Predictive Model building 
- A subset of the original data was sampled from the three sources (blogs,twitter and news) which is then merged into one and data cleansing on text is performed
- The corresponding n-grams are then created (Quadgram,Trigram and Bigram).
- Next, the term-count tables are extracted from the N-Grams and sorted according to the frequency in descending order,these n-gram objects are saved as R-Compressed files (.RData - files)

The Dataset 
========================================================
The Prediction Model built within this shiny app was from the Swiftkey HC Corpora dataset and it comprised of the output of lots of news sites, blogs and twitter. The dataset contains 3 files across four languages (Russian, Finnish, German and English). This project was focused on the English language datasets. The names of the data files are as follows:

1. en_US.blogs.txt
2. en_US.twitter.txt
3. en_US.news.txt

![alt text](dataset.png)

User Interface of the Application
========================================================
Text Prediction Model based on N-grams implementing the backoff algorithm

![alt text](swiftkeymini.png)

Application Resources & Algorithm implemented
========================================================
## Underlying algorithm 

* N-gram model with "Stupid Backoff" (Brants et al 2007)
* Checks if highest-order (in this case, n=4) n-gram has been seen.   If not "degrades" to a lower-order model (n=3, 2); the logic could   have used even with higher orders, but ShinyApps caps app size at   100mb and text-mining involves high computing power on large 
  text corpus files.

Hosted Application Link 
<https://maddev.shinyapps.io/swiftkeymini/>

Source Code Repository Link 
<https://github.com/Maddev25/DSC.git>
