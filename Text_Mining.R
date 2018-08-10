## Text Mining - Basic Prediction Model 
## Author Vasudevan D 
## Date   03 August 2018 

## Load required libraries for processing 
library(stringr)
library(stringi)
library(tm)
library(wordcloud)
library(ggplot2)

## Read all documents in the Swift key dataset 
## Set the line count information for extraction 
linesToExtract <- -1 

## Open the file connection 
blogsC <- file("./final/en_US/en_US.blogs.txt", "r")
newsC  <- file("./final/en_US/en_US.news.txt", "r")
twitterC <- file("./final/en_US/en_US.twitter.txt", "r")

blogsS <- readLines(blogsC, n=linesToExtract, encoding = "UTF-8")
newsS  <- readLines(newsC, n= linesToExtract, encoding = "UTF-8")
twitterS <- readLines(twitterC, n=linesToExtract, encoding = "UTF-8")

## Close the file connection
close(blogsC)
close(newsC)
close(twitterC)

## Remove retweets from Twitter Data Sample 
twitterS <- gsub ("(RT|via)((?:\\b\\W*@\\w+)+)", "", twitterS)

## Remove @people names from Twitter 
twitterS <- gsub("@\\w+", "",twitterS)

#Select ALL DOCUMENTS in Blogs
allBlogs <- blogsS
#Select ALL DOCUMENTS in News
allNews <- newsS
#Select ALL DOCUMENTS in Twitters
allTwitter <- twitterS

## Tokenization function                  
tokenmaker <- function(x) {
 corpus <- Corpus(VectorSource(x))
 corpus <- tm_map(corpus, content_transformer(tolower))
 corpus <- tm_map(corpus, removePunctuation)
 corpus <- tm_map(corpus, stripWhitespace)
 corpus <- tm_map(corpus, removeWords, stopwords("english"))
 corpus <- tm_map(corpus, removeNumbers)
 corpus <- tm_map(corpus, PlainTextDocument)
 #        corpus <- tm_map(corpus, stemDocument)
 corpus <- Corpus(VectorSource(corpus))
}  

## Word counter from TDM 
wordcounter <- function(x) {
 dtm<-DocumentTermMatrix(x)
 dtm_matrix <- as.matrix(dtm)
 word_freq <- colSums(dtm_matrix)
 word_freq <- sort(word_freq, decreasing = TRUE)
 words <- names(word_freq)
 return(list(words, word_freq))
}  

## Next Word Prediction function 
NextWordIs <- function(x,y){
 BQuest<-grepl(x, allBlogs, ignore.case=TRUE)
 BDocs<-allBlogs[BQuest]
 textoachado<-'a'
 NextWordIs<-'a'
 i<-length(BDocs)
 if (i>0)
 {
     for (i in 1:i)
     {  textoachado[i]<- str_extract(BDocs[i], y)
     NextWordIs[i]<- stri_extract_last_words(textoachado[i]) 
     }
 }
 NQuest<-grepl(x, allNews, ignore.case=TRUE)
 NDocs<-allNews[NQuest]
 j=length(NDocs)
 if (j>0)
 {
     for (j in 1:j)
     {  textoachado[i+j]<- str_extract(NDocs[j], y)
     NextWordIs[i+j]<- stri_extract_last_words(textoachado[i+j]) 
     }
 }
 TQuest<-grepl(x, allTwitter, ignore.case=TRUE)
 TDocs<-allTwitter[TQuest]
 k=length(TDocs)
 if (k>0)
 {
     for (k in 1:k)
     {  textoachado[i+j+k]<- str_extract(TDocs[k], y)
     NextWordIs[i+j+k]<- stri_extract_last_words(textoachado[i+j+k]) 
     }
 }
 bundle<-as.data.frame(NextWordIs, stringsAsFactors=FALSE)
 summary (bundle)
 blogs_token <- tokenmaker(bundle)
 blogs_words <- wordcounter(blogs_token)
 summary(nchar(bundle))
 head(bundle)
 tdm_Blogs<-TermDocumentMatrix(blogs_token)
 m_Blogs<-as.matrix(tdm_Blogs)
 v_Blogs<-sort(rowSums(m_Blogs),decreasing=TRUE)
 d_Blogs<-data.frame(word=names(v_Blogs),freq=v_Blogs)
 head(v_Blogs, 100)    
 return(list(head(v_Blogs,100)))
}

## Predict function 
##predict01<-NextWordIs("a case of ", "([Aa]+ +[Cc]ase+ +[Oo]f+ +[^ ]+ )" )
##predict01