% Define diseases and their symptoms
disease(ebola) :- symptom(fever), symptom(bleeding), symptom(weakness), symptom(pain), symptom(fatigue).
disease(covid_19) :- symptom(fever), symptom(cough), symptom(shortness_of_breath), symptom(loss_of_taste), symptom(headache).
disease(jaundice) :- symptom(yellow_skin), symptom(yellow_eyes), symptom(dark_urine), symptom(fatigue), symptom(abdominal_pain).
disease(chickenpox) :- symptom(rash), symptom(fever), symptom(fatigue), symptom(headache), symptom(loss_of_appetite).
disease(typhoid_fever) :- symptom(fever), symptom(headache), symptom(abdominal_pain), symptom(constipation), symptom(weakness).

% Define symptoms (this part is dynamic and will change as user inputs symptoms)
:- dynamic symptom/1.

% Ask for symptoms one by one
ask_symptom(Symptom) :-
    format('Do you have ~w? (yes/no) ', [Symptom]),
    read(Response),
    (Response == yes -> assert(symptom(Symptom)); true).

% Diagnose the disease based on symptoms
diagnose :-
    ask_symptom(fever),
    ask_symptom(bleeding),
    ask_symptom(weakness),
    ask_symptom(pain),
    ask_symptom(fatigue),
    ask_symptom(cough),
    ask_symptom(shortness_of_breath),
    ask_symptom(loss_of_taste),
    ask_symptom(headache),
    ask_symptom(yellow_skin),
    ask_symptom(yellow_eyes),
    ask_symptom(dark_urine),
    ask_symptom(abdominal_pain),
    ask_symptom(rash),
    ask_symptom(loss_of_appetite),
    ask_symptom(constipation),
    (disease(Disease) -> format('You might have ~w.~n', [Disease]); write('Disease could not be identified with the given symptoms.')).

% Start the diagnosis process
start :-
    write('Welcome to the disease diagnosis system.'), nl,
    write('Please answer the following questions with yes or no.'), nl,
    diagnose.
