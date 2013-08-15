---
layout: blog_post
title: Metacognition for Problem Solving.
excerpt: Putting a method to the madness. 
---
Would I be called 'negligent' for failing to refine my methods?
<br>
<p>     Arguably, the most valuable lesson I learned from taking a proof-centric course in computation theory is that problem solving requires a structured process. Prior to that realization, I approached many of my proofs by applying the Richard Feynman algorithm.</p>

>The Richard Feynman Algorithm:
>    <ol>
>        <li>Look at the problem.</li>
>        <li>Think really hard.</li>
>        <li>Write down the solution</li>
>    </ol>
>    

<p>For the most part, the Feynman algorithm had served me well provided I approached candidate solutions with skepticism. After some refinement of my intuitive guesses, the results are considerably acceptable. The Feynman algorithm and a strong dose of nondeterminism where applicable (nondeterminism is an academic way of saying 'just brute-force the damn solution') quickly yields solutions to most proofs involving finite automata and context-free-grammars. Soon proofs became more complex as the turing machine decided to rear its ugly head. My strategy consisting of gut instincts and consulting patterns from previous proofs proved indequate when my goal was to reliably generate a proof under delicate time constraints (after all, most of these proofs were from problem sets with deadlines or exams with even stricter deadlines). Randomly trying ideas and building an intuition from past failures is a good way to understand the material but a bad way for solving the proof. With no guarantee that a solution may be found, the Feynman algorithm is not reliable for solving novel problems. A new method was required.</p>

>The Fantastic Algorithm:
>   <ol>
>       <li>Consider necessary intermediate requirements for reaching the proof's desired state.</li>
>       <li>Somehow fulfill all the intermediate requirements.</li>
>       <ol>
>           <li>If conclusively impossible, start from the top with a new set of intermediate states.</li>
>       </ol>
>       <li>Write down the solution.</li>
>   </ol>
>

<p>The Fantastic algorithm lived up to its name in all but one respect: fulfilling the intermediate requirements was not a trivial task.
Proving some set of conditions was conclusively impossible to fulfil required an expedition deep into the semantics of the conditions and looking for incongruities. Often times when a clear direction to the solution is missing, the Fantastic Algorithm is an exercise in brute-forcing the 'intermediate-condition'-space of the problem. This systematic approach is still a step up from the chaotic approach of the Feynman Algorithm since it does guarantee that sooner or later, a proof will be found.</p>

