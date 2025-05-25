% =====================
% Entry Point (with fallback message)
% =====================

start :- 
    intro, 
    reset_answers,
    ( find_career_path(CareerPath) ->
        nl,
        write('************************************************************'), nl,
        write('Recommended career path:'), nl,
        write('- '), write(CareerPath), nl
    ; 
        nl,
        write('************************************************************'), nl,
        write('Sorry, we could not determine a career path based on your answers.'), nl,
        write('Consider exploring diverse fields or retaking the test with different responses.'), nl
    ).

% =====================
% Introduction
% =====================

intro :-
    write('*******************************************************************'), nl,
    write('                       Welcome to CareerWizard                     '), nl,
    write('               Find out which career suits you best now!           '), nl,
    write('*******************************************************************'), nl,
    write('To answer, input the number shown next to each answer, followed by a dot (e.g., 0.)'), nl, nl.

% =====================
% State Handling
% =====================

:- dynamic(progress/2).

reset_answers :- 
    retractall(progress(_, _)).

% =====================
% Question Asking
% =====================

ask(Question, Answer, Choices) :- 
    \+ progress(Question, _), !, 
    question(Question), 
    show_choices(Choices, 0), 
    read(Index), 
    (   nth0(Index, Choices, Response) 
    ->  asserta(progress(Question, Response)), 
        Answer = Response 
    ;   write('Invalid choice. Please try again.'), nl, 
        ask(Question, Answer, Choices) 
    ). 

ask(Question, Answer, _) :- 
    progress(Question, Answer).

show_choices([], _).
show_choices([Choice|Rest], Index) :- 
    format('~d. ', [Index]), 
    answer(Choice), 
    nl, 
    NextIndex is Index + 1, 
    show_choices(Rest, NextIndex).

yn_question(Q, Answer) :- 
    ask(Q, Answer, [yes, no]).

% =====================
% Career Path Determination
% =====================

find_career_path(CareerPath) :-
    career_path(CareerPath), !.

% =====================
% Career Path Rules
% =====================

career_path('Technology - Software Development') :-
    subject(computing, E),
    (yn_question(computer_systems, yes) ; ask(technology, develop, [apply, develop])),
    nl,
    write(E), nl,
    write('Your ideal career field is Technology with a focus on Software Development.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Software Engineer',
        'Mobile App Developer',
        'Game Developer',
        'System Architect',
        'DevOps Engineer',
        'Machine Learning Engineer'
    ]), nl.

career_path('Technology - IT Infrastructure') :-
    subject(computing, E),
    nl,
    write(E), nl,
    write('Your ideal career field is Technology with a focus on IT Infrastructure.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'IT Consultant',
        'Network Engineer',
        'Cloud Architect',
        'Database Administrator',
        'Cybersecurity Specialist',
        'Systems Administrator'
    ]), nl.

career_path('Engineering - Electrical') :-
    subject(engineering, E),
    yn_question(physics, yes),
    yn_question(circuits, yes),
    nl,
    write(E), nl,
    write('Your ideal career field is Engineering with a focus on Electrical Systems.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Electrical Engineer',
        'Electronics Designer',
        'Power Systems Engineer',
        'Control Systems Engineer',
        'Telecommunications Engineer'
    ]), nl.

career_path('Engineering - Mechanical') :-
    subject(engineering, E),
    yn_question(physics, yes),
    nl,
    write(E), nl,
    write('Your ideal career field is Engineering with a focus on Mechanical Systems.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Mechanical Engineer',
        'Automotive Engineer',
        'Robotics Engineer',
        'HVAC Engineer',
        'Manufacturing Engineer'
    ]), nl.

career_path('Science - Biotechnology') :-
    subject(science, E),
    yn_question(biology, yes),
    yn_question(genetic_engineering, yes),
    nl,
    write(E), nl,
    write('Your ideal career field is Science with a focus on Biotechnology.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Biotech Researcher',
        'Pharmaceutical Scientist',
        'Genetic Counselor',
        'Bioinformatics Specialist',
        'Clinical Research Coordinator'
    ]), nl.

career_path('Business - Marketing') :-
    subject(business, E),
    yn_question(storytelling, yes),
    nl,
    write(E), nl,
    write('Your ideal career field is Business with a focus on Marketing.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Digital Marketing Specialist',
        'Brand Strategist',
        'Market Research Analyst',
        'Advertising Executive',
        'Social Media Manager'
    ]), nl.

career_path('Psychology & Counseling') :-
    yn_question(interested_behavior, yes),
    yn_question(empathic, yes),
    yn_question(listening_skills, yes),
    nl,
    write('You are empathetic and interested in understanding human behavior.'), nl,
    write('Your ideal career field is Psychology & Counseling.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Clinical Psychologist',
        'Mental Health Counselor',
        'Organizational Psychologist',
        'School Counselor',
        'Human Resources Specialist'
    ]), nl.

career_path('Legal Services') :-
    yn_question(interest_in_justice, yes),
    yn_question(verbal_skills, yes),
    yn_question(argumentative, yes),
    nl,
    write('You are passionate about justice and have strong communication skills.'), nl,
    write('Your ideal career field is Legal Services.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Corporate Lawyer',
        'Public Defender',
        'Legal Consultant',
        'Compliance Officer',
        'Paralegal'
    ]), nl.

career_path('Finance & Accounting') :-
    yn_question(work_with_numbers, yes),
    yn_question(detail_oriented, yes),
    ask(logical_or_analytical, logical, [logical, analytical]),
    nl,
    write('You are detail-oriented and good with numbers and logic.'), nl,
    write('Your ideal career field is Finance & Accounting.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Financial Analyst',
        'Certified Accountant',
        'Investment Banker',
        'Risk Manager',
        'Actuary'
    ]), nl.

career_path('Design & Architecture') :-
    yn_question(creative_artistic_musical, yes),
    ask(logic_or_imagination, imagination, [logic, imagination]),
    yn_question(visual_thinker, yes),
    nl,
    write('You are imaginative, visual, and creative.'), nl,
    write('Your ideal career field is Design & Architecture.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Architect',
        'Urban Designer',
        'Interior Designer',
        'Landscape Architect',
        'Graphic Designer'
    ]), nl.

career_path('Education') :-
    yn_question(like_teaching, yes),
    yn_question(patience, yes),
    yn_question(planning, yes),
    nl,
    write('You are patient, enjoy teaching, and like planning.'), nl,
    write('Your ideal career field is Education.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Teacher',
        'Educational Consultant',
        'Curriculum Developer',
        'School Administrator',
        'Corporate Trainer'
    ]), nl.

career_path('History & Cultural Studies') :-
    yn_question(interested_in_past, yes),
    yn_question(research_oriented, yes),
    ask(preferred_medium, written_word, [written_word, visual_arts]),
    nl,
    write('You are fascinated by history and enjoy research.'), nl,
    write('Your ideal career field is History & Cultural Studies.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Historian',
        'Archaeologist',
        'Cultural Heritage Manager',
        'Archivist'
    ]), nl.

career_path('Healthcare - Clinical') :-
    yn_question(helping_people, yes),
    yn_question(science, yes),
    yn_question(work_under_pressure, yes),
    nl,
    write('You are scientifically-minded and want to help people directly.'), nl,
    write('Your ideal career field is Healthcare - Clinical.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Physician',
        'Surgeon',
        'Nurse Practitioner',
        'Clinical Researcher'
    ]), nl.

career_path('Healthcare - Allied Health') :-
    yn_question(helping_people, yes),
    (yn_question(science, yes) ; yn_question(technical_skills, yes)),
    nl,
    write('You want to help people through healthcare services.'), nl,
    write('Your ideal career field is Healthcare - Allied Health.'), nl,
    write('Potential career roles include:'), nl,
    print_list([
        'Physical Therapist',
        'Medical Laboratory Scientist',
        'Radiologic Technologist',
        'Occupational Therapist'
    ]), nl.

% =====================
% Subject Rules
% =====================

subject(computing, E) :-
    (logical_thinking ; imaginary_thinking),
    ask(better_in, solving_problem, [solving_problem, dealing_with_people]),
    ask(computer_or_hands, computer, [computer, hands]),
    (yn_question(work_with_numbers, yes) -> yn_question(maths, yes) ; true),
    E = 'You prefer computing: problem-solving using computers, possibly with maths skills.'.

subject(engineering, E) :-
    yn_question(science, yes),
    ask(theory_or_practical, practical, [theory, practical]),
    ask(better_in, solving_problem, [solving_problem, dealing_with_people]),
    yn_question(challenge_yourself, yes),
    E = 'You love science, practical work, problem solving and challenges.'.

subject(science, E) :-
    yn_question(science, yes),
    ask(theory_or_practical, theory, [theory, practical]),
    E = 'You love science and prefer theory over practical.'.

subject(business, E) :-
    yn_question(like_interact, yes),
    ask(better_in, dealing_with_people, [solving_problem, dealing_with_people]),
    yn_question(planning, yes),
    E = 'You enjoy interacting with people, dealing with people and planning.'.

% =====================
% Logic / Imagination
% =====================

logical_thinking :-
    ask(logic_or_imagination, logic, [logic, imagination]),
    yn_question(rational, yes).

imaginary_thinking :-
    ask(logic_or_imagination, imagination, [logic, imagination]),
    yn_question(rational, no).

% =====================
% Questions
% =====================

question(logic_or_imagination) :- write('Are you a person of logic or imagination?'), nl.
question(rational) :- write('Are you a rational person?'), nl.
question(science) :- write('Do you like Chemistry/Biology/Physics?'), nl.
question(theory_or_practical) :- write('Do you prefer theory or practical work?'), nl.
question(better_in) :- write('What are you better in?'), nl.
question(computer_or_hands) :- write('Do you prefer working on computer or with hands?'), nl.
question(like_interact) :- write('Do you like interacting with people?'), nl.
question(serving_people) :- write('Do you mind serving people?'), nl.
question(work_with_numbers) :- write('Do you like working with numbers?'), nl.
question(creative_artistic_musical) :- write('Are you creative/artistic/musical?'), nl.
question(computer_systems) :- write('Are you interested in how computer systems work?'), nl.
question(technology) :- write('Do you prefer to apply or develop technology?'), nl.
question(physics) :- write('Do you enjoy Physics?'), nl.
question(circuits) :- write('Do you like working with circuits?'), nl.
question(biology) :- write('Do you like Biology?'), nl.
question(genetic_engineering) :- write('Do you find genetic engineering interesting?'), nl.
question(storytelling) :- write('Are you good at storytelling?'), nl.
question(maths) :- write('Are you good at Maths?'), nl.
question(challenge_yourself) :- write('Do you like to challenge yourself?'), nl.
question(planning) :- write('Do you like planning?'), nl.
question(interested_behavior) :- write('Are you interested in human behavior and psychology?'), nl.
question(empathic) :- write('Do people consider you an empathetic person?'), nl.
question(listening_skills) :- write('Are you a good listener?'), nl.
question(interest_in_justice) :- write('Are you passionate about justice and laws?'), nl.
question(verbal_skills) :- write('Do you have strong verbal and written communication skills?'), nl.
question(argumentative) :- write('Do you enjoy debates or forming arguments?'), nl.
question(detail_oriented) :- write('Are you detail-oriented?'), nl.
question(logical_or_analytical) :- write('Are you more logical or analytical?'), nl.
question(visual_thinker) :- write('Are you good at visualizing designs and spaces?'), nl.
question(like_teaching) :- write('Do you enjoy teaching or sharing knowledge?'), nl.
question(patience) :- write('Are you a patient person?'), nl.
question(interested_in_past) :- write('Are you deeply interested in history and the past?'), nl.
question(research_oriented) :- write('Do you enjoy research and detailed analysis?'), nl.
question(preferred_medium) :- write('Do you prefer working with the written word or visual arts?'), nl.
question(helping_people) :- write('Do you feel strongly about helping and caring for people?'), nl.
question(work_under_pressure) :- write('Can you work effectively under pressure?'), nl.
question(technical_skills) :- write('Do you have strong technical or hands-on skills?'), nl.

% =====================
% Answers
% =====================

answer(logic) :- write('Logic').
answer(imagination) :- write('Imagination').
answer(yes) :- write('Yes').
answer(no) :- write('No').
answer(theory) :- write('Theory').
answer(practical) :- write('Practical').
answer(solving_problem) :- write('Solving problems').
answer(dealing_with_people) :- write('Dealing with people').
answer(computer) :- write('Computer').
answer(hands) :- write('Hands').
answer(apply) :- write('Apply technology').
answer(develop) :- write('Develop technology').
answer(logical) :- write('Logical').
answer(analytical) :- write('Analytical').
answer(written_word) :- write('Written word').
answer(visual_arts) :- write('Visual arts').
answer(research_oriented) :- write('Research-oriented').
answer(interested_in_past) :- write('Interested in history').

% =====================
% Print List Helper
% =====================

print_list([]).
print_list([H|T]) :-
    write('- '), write(H), nl,
    print_list(T).