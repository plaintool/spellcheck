unit sample;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LCLType, RichMemo,
  SpellChecker;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1: TPanel;
    RichMemo1: TRichMemo;
    SpellChecker1: TSpellChecker;
    procedure FormCreate(Sender: TObject);
    procedure RichMemo1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
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

  // Set a small left indent for the whole text: the resulting left margin
  // makes it easier to select text line by line without hitting the border.
  RichMemo1.SetLeftIndent(5);

  {$IFDEF UNIX}
  // Attach the custom undo/redo tracker on Linux only, because on Windows
  // the native RichEdit undo stack is used instead.
  RichMemo1.EnableUndo;
  {$ENDIF}
end;

procedure TForm1.RichMemo1KeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  // Handle ctrl shortcuts for rich memo editing
  if ssCtrl in Shift then
  begin
    case Key of
      VK_C: begin
        // Ctrl+C, copy selected text to clipboard
        RichMemo1.CopyToClipboardEx;
        Key := 0;
      end;
      VK_V: begin
        // Ctrl+V, paste text from clipboard
        RichMemo1.PasteFromClipboardEx(False);
        Key := 0;
      end;
      VK_Z: begin
        // Ctrl+Z, undo last action
        RichMemo1.UndoEx;
        Key := 0;
      end;
      VK_Y: begin
        // Ctrl+Y, redo last undone action
        RichMemo1.RedoEx;
        Key := 0;
      end;
    end;
  end;
end;

end.
