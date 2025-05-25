# 🧠 CareerWizard Expert System

CareerWizard is a rule-based expert system developed in **Prolog** to assist individuals in identifying suitable career paths based on their interests, skills, and personality traits. It serves as a smart guidance tool for students, career changers, and counselors.

---

## 🎯 Purpose

- ✅ Assess user preferences via an interactive questionnaire
- ✅ Match responses to predefined rules for career compatibility
- ✅ Recommend personalized career paths with explanations
- ✅ Support exploration of less-considered options

---

## 👥 Who It’s For

- **Students** seeking guidance on field or major selection
- **Professionals** exploring new or more suitable careers
- **Career Counselors** using it as a supplementary tool

---

## 🔧 Technical Overview

- Built with: **Prolog**
- Components:
  - Dynamic knowledge base using `progress/2` facts
  - Rule-based reasoning for career path decisions
  - Structured Q&A interaction system
  - Subject and career path matching rules (e.g., engineering, design, healthcare)

---

## 🧠 Sample Career Rules

```prolog
career_path('Engineering - Mechanical') :-
    subject(engineering, _),
    yn_question(physics, yes).

career_path('Technology - Software Development') :-
    subject(computing, _),
    yn_question(computer_systems, yes).
```
## 📌 Features
- Logical rule evaluation (A → B)
- Dynamic state tracking (assert, retract)
- Depth-first inference with backtracking
- Graceful fallback when no match found
- Modular and extensible design

## 🚀 How to Run the System
1. Install SWI-Prolog
https://www.swi-prolog.org/Download.html

2. Load the Expert System:
```bash
?- [careerwizard].
```
3. Start the System
```bash
?- start.
```
Follow the interactive prompts to answer questions about your preferences.

## 📢 Conclusion
CareerWizard effectively demonstrates how rule-based AI can be applied to real-world decision support. It combines structured knowledge with dynamic reasoning to deliver valuable, explainable career suggestions.


