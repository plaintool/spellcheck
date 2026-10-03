unit sample;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, RichMemo, SpellChecker;

type

  { TForm1 }

  TForm1 = class(TForm)
    RichMemo1: TRichMemo;
    SpellChecker1: TSpellChecker;
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

end.

