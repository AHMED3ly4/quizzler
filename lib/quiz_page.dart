import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizPage extends StatefulWidget {

  @override
  State<QuizPage> createState() => _MyAppState();
}

class _MyAppState extends State<QuizPage> {
  List<Icon> scoreKeeper=[];
  int score=0;
  QuizBrain quizBrain = QuizBrain();
  void checkAnswer(bool userAnswer){
    setState(() {
      if(quizBrain.isFinished()){
        Alert(context: context, title: "Finished!", desc: "your score is $score").show();
        quizBrain.resetQuestions();
        scoreKeeper=[];
        score=0;
      }
      else{
        if(userAnswer==quizBrain.getAnswers()){
          scoreKeeper.add(
            const Icon(Icons.check,color: Colors.green,),
          );
          score++;
        }
        else{
          scoreKeeper.add(
            const Icon(Icons.close,color: Colors.red,),
          );
        }
        quizBrain.nextQuestion();
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestion() ,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      checkAnswer(true);
                    },
                    child: const Text(
                      'Yes',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      checkAnswer(false);
                    },
                    child: const Text(
                      'No',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        scoreKeeper.clear();
                        score=0;
                      });
                    },
                    child: const Text(
                      'Reset',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Row(
                children: scoreKeeper,
              ),
            ],
          ),
        ),
      ),
    );
  }
}