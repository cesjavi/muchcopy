unit Umcopy;

interface

type
  TCopyType = (Bitmap, Text);
  TCopy = class
    private
      FDate: TDateTime;
      FDescription: String;
      FValue: String;
      FCopyType: TCopyType;
      FEncrypted: Boolean;
      FStuff: String;
    public
      property Date: TDateTime read FDate write FDate;
      property Description: String read FDescription write FDescription;
      property Value: String read FValue write FValue;
      property CopyType: TCopyType read FCopyType write FCopyType;
      property Encrypted: Boolean read FEncrypted write FEncrypted;
      property Stuff: String read FStuff write FStuff;
      constructor Create();
      //constructor Create(date: TDateTime; description: AnsiString; value: AnsiString; copytype: TCopyType);
  end;

implementation

//  constructor TCopy.Create(date: TDateTime; description: AnsiString; value: AnsiString; copytype: TCopyType);
  constructor TCopy.Create();
  begin
    inherited;
      //Date := date;
      //Description := description;
      //Value := Value;
      //CopyType := copytype;
  end;

end.
