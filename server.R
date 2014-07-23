# Load Data
Motor = read.csv("Motor.csv")
names(Motor)[1] = "A1"
Variable = readLines("Variable.csv",encoding="UTF-8")
Variable_Explain = strsplit(Variable[2:87],",")
Variable_Name = rep(NA,86)
for(k in 1:86){
  Variable_Explain[[k]] = Variable_Explain[[k]][lapply(Variable_Explain[[k]],nchar)>0]
  Variable_Name[k] = Variable_Explain[[k]][1]
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
      NA_ratio = sum(is.na(Motor[,input$column]))/10481
      if( NA_ratio < 0.5 )
        slice = table(Motor[,input$column],useNA="always")
      else
        slice = table(Motor[,input$column],useNA="no")
      
      #slice = as.integer(slice)
      
      index = which(Variable_Name == names(Motor)[input$column] )
      Show_text = Variable_Explain[[index]]
      Explain = Show_text[4:length(Show_text)]
      lbls = Explain[seq(2,length(Explain),by=2)]
      
      if(NA_ratio < 0.5 ) lbls = c(lbls,"NA")
      if(Show_text[3]=="¶}©ñÃD") plot.new()
      else{
        if(length(slice)>=1){
          if(is.na(rownames(slice)[length(slice)])) rownames(slice)[length(slice)] = "NA"
          plot((slice) ,lwd=15)
        }
        else{
          pie3D(slice,labels=paste(lbls,":","(",round(slice/sum(slice),3)*100,"%)",sep=""),explode=0.1,radius=1.8,
                main=paste(Show_text[2]) , col=c(3:5) )
        }
      }
  })
  
  output$Code <- renderText({
    index = which(Variable_Name == names(Motor)[input$column] ) 
    Show_text = Variable_Explain[[index]]
    code = Show_text[1]
    paste("Code:",code)
  })
  
  output$Question <- renderText({  
    index = which(Variable_Name == names(Motor)[input$column] )
    Show_text = Variable_Explain[[index]]
    question = Show_text[2]
    paste("Question:",question)
  })
  
  output$Type <- renderText({
    index = which(Variable_Name == names(Motor)[input$column] )
    Show_text = Variable_Explain[[index]]
    type = Show_text[3]
    paste("Type",type)
  })
  
  output$Explain <- renderText({
    index = which(Variable_Name == names(Motor)[input$column] )
    Show_text = Variable_Explain[[index]]
    Explain = Show_text[4:length(Show_text)]
    c("Content:",Explain)
  })
  
})

