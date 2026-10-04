unit sample;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, RichMemo,
  SpellChecker;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1: TPanel;
    RichMemo1: TRichMemo;
    SpellChecker1: TSpellChecker;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

uses ControlsHelper, RichMemoHelper;

  {$R *.lfm}

  { TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Enable WS_EX_COMPOSITED on Panel1 (WinAPI double buffering).
  // Reduces flicker for Panel1 and its children, including RichMemo.
  Panel1.SetComposited(True);

  // Workaround for RichMemo/RichEdit scrollbar repaint artifacts on Windows.
  // Stores the parent handle and runs a timer to force repaints.
  RichMemo1.EnableScrollbarFix(Panel1);
end;

end.
