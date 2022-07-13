program Wordy;

uses
  CRT, Graph;

var
  guess: string;
  word: string[5];

  guessnum: integer;
  matches: integer;

procedure ReadGuess(var AGuess: string; Length: integer);
var
  ltr, ch, i: integer;
begin
  textBackground(black);
  Window(3, 4, 23, 7);
  ClrScr;

  textBackground(Red);
  textColor(Yellow);
  Window(2, 3, 22, 6);

  ClrScr;

  GotoXY(5, 2);
  Write('Make a guess');

  { Center the guess }
  GotoXY(10 - (Length div 2), 3);
  for i := 1 to Length do
  begin
    Write('-');
  end;
  GotoXY(10 - (Length div 2), 3);

  { Read the guess }
  ltr := 0;
  repeat
    ch := ord(ReadKey);
    if ch = 0 then
      ReadKey;
    if (ch >= ord('a')) and (ch <= ord('z')) then
      ch := ord(upcase(chr(ch)));

    if (ch >= ord('A')) and (ch <= ord('Z')) then
    begin
      GotoXY(10 - (Length div 2) + ltr, 3);
      Write(chr(ch));

      AGuess[ltr] := chr(ch);
      inc(ltr);
    end;

    { Backspace handler }
    if ch = 8 then
    begin
      if ltr > 0 then
      begin
        AGuess[ltr - 1] := #0;
        GotoXY(10 - (Length div 2) + ltr - 1, 3);
        Write('-');
        GotoXY(10 - (Length div 2) + ltr - 1, 3);
        dec(ltr);
      end;
    end;

  until (ltr >= Length);
  GotoXY(2, 4);
  Write(AGuess);
end;

procedure PrintLetter(ALetter: char; AColor: integer; ALeft: integer;
  ATop: integer);
begin

  textBackground(AColor);
  Window(ALeft, ATop, ALeft + 2, ATop + 2);
  ClrScr;

  GotoXY(2, 2);
  textColor(White);
  Write(ALetter);
  Delay(100);
end;

function CompareWords(AWord: string; AGuess: string; ALeft: integer;
  ATop: integer): integer;
var
  ltr, pos, color: integer;
begin
  matches := 0;
  CompareWords := 0;

  for ltr := 0 to 4 do
  begin
    if AWord[ltr + 1] = AGuess[ltr] then
    begin
      PrintLetter(AGuess[ltr], Green, ALeft + (4 * ltr), ATop);
      inc(matches);
    end
    else
    begin
      color := black;
      for pos := 1 to Length(AWord) do
        if AWord[pos] = AGuess[ltr] then
          color := Yellow;

      PrintLetter(AGuess[ltr], color, ALeft + (4 * ltr), ATop);
    end;
  end;

  CompareWords := matches;
end;

procedure PrintTitle(Title: string);
begin
  textBackground(Cyan);
  Window(1, 1, 80, 1);
  ClrScr;

  textColor(White);
  GotoXY(40 - (Length(Title) div 2), 1);
  Write(Title);
end;

begin
  guessnum := 0;
  matches := 0;
  word := 'WORDY';

  { SETUP }
  TextMode(C80);
  textBackground(Blue);
  ClrScr;

  { PRINT TITLE }
  PrintTitle('WORDY - a word puzzle game');

  { PLAY GAME }
  while (guessnum < 6) and (matches < 5) do
  begin
    ReadGuess(guess, 5);

    GotoXY(50, 10);

    { compare the guess to the word }
    matches := CompareWords(word, guess, 30, 3 + (guessnum * 4));

    inc(guessnum);
  end;

  if (matches = 5) then
    PrintTitle('You guessed the secret word!')
  else
    PrintTitle('Sorry, you didn''t guess the world');

  ReadKey;
  ClrScr;

end.
