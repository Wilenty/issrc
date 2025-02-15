# InnoSetup pascal bugs reported on their forum in 2022.

Of course, everyone makes mistakes, but the most important thing is whether they want to do something about those mistakes.

Owners of the InnoSetup would not answer at all, instead I had to talk with Eivind Bakkestuen that unwilling to comprehend:<br>
![2022.png](2022.png)

And later (2024) he asking for reporting "more problems"?:<br>
https://groups.google.com/g/innosetup/c/fNDrkcdJnHg/m/MurZ2uilAAAJ

![2024.png](2024.png)

I add an example "4.iss" created later to show the same error in action on a real installer, but not just as an "example".

It compiles without any problems, but won't let you install the file because of this error. So, what is a more serious bug than breaking the basic functionality of the installer?<br>
I'm posting this here because writing on their forum has not brought any response from the owners, maybe they will finally notice this bug (which has many possibilities) and fix it?<br>
And, puzzling operation of the InnoSetup.

To show you it's not "one time situation", take a look at this:<br>
Compile.pas / Compiler.SetupCompiler.pas -> `if (ADestDir = '{tmp}') or (Copy(ADestDir, 1, 4) = '{tmp}\') then`

v5.5.0: 
https://github.com/jrsoftware/issrc/blob/is-5_5_0/Projects/Compile.pas#L6349

v5.5.5: 
https://github.com/jrsoftware/issrc/blob/is-5_5_5/Projects/Compile.pas#L6307

v5.6.1: 
https://github.com/jrsoftware/issrc/blob/is-5_6_1/Projects/Compile.pas#L6472

v6.0.5: 
https://github.com/jrsoftware/issrc/blob/is-6_0_5/Projects/Compile.pas#L6577

v6.1.2: 
https://github.com/jrsoftware/issrc/blob/is-6_1_2/Projects/Compile.pas#L6395

v6.2.2: 
https://github.com/jrsoftware/issrc/blob/is-6_2_2/Projects/Compile.pas#L6377

v6.3.3: 
https://github.com/jrsoftware/issrc/blob/is-6_3_3/Projects/Src/Compile.pas#L6280

v6.4.0: 
https://github.com/jrsoftware/issrc/blob/is-6_4_0/Projects/Src/Compiler.SetupCompiler.pas#L5251

v6.4.1: 
https://github.com/jrsoftware/issrc/blob/is-6_4_1/Projects/Src/Compiler.SetupCompiler.pas#L5251

It they can't count simple string/text, I created simple command-line program named "Help4ISdevs.dpr" to help them.

---

Also look at the bugs in the chm help file there:<br>
https://github.com/Wilenty/InnoSetup_Unpacker-Extractor_/releases/tag/v6.4.0+

And/Or at the bug in the TNewCheckListBox (mentioned in the section "Fixed") there:<br>
<a href="https://github.com/Wilenty/InnoSetup-with-latest-LZMA/releases/tag/v6.4.1-{2025-02-12}">https://github.com/Wilenty/InnoSetup-with-latest-LZMA/releases/tag/v6.4.1-{2025-02-12}</a>

---

**InnoSetup installer (program) is full of bugs that owners don't want to see, or simply ignore. Sad, but true.**<br>
I don't write more, because I have no words for that kind of reluctance to act.
