unit TabbedTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation,
  FB4D.Interfaces, FB4D.RealTimeDB, FMX.Objects, FMX.ScrollBox, FMX.Memo,
  FB4D.Authentication, FB4D.Helpers, System.JSON,
  System.StrUtils, umcopy, REST.JSON,
  System.JSON.Types, System.Json.Serializers,
{$IFDEF TOKENJWT}
  FB4D.OAuth,
{$ENDIF}
  FB4D.Response, FB4D.Request, FB4D.Functions, FB4D.Storage,
  FB4D.Firestore, FB4D.Document,
  FMX.Edit, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.Platform, System.Rtti, FMX.Surfaces, System.NetEncoding,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Memo.Types;

type
  TTabbedForm = class(TForm)
    HeaderToolBar: TToolBar;
    ToolBarLabel: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    tabCopy: TTabItem;
    tabPaste: TTabItem;
    tabConfig: TTabItem;
    GestureManager1: TGestureManager;
    btnUpdate: TButton;
    Usuario: TLabel;
    lClave: TLabel;
    btnLogin: TButton;
    memUser: TMemo;
    txtPassword: TEdit;
    txtUser: TEdit;
    lvCopies: TListView;
    btnPaste: TButton;
    btnUpload: TButton;
    ImageControl1: TImageControl;
    txtTest: TEdit;
    Button1: TButton;
    procedure PutRTSynchClick();
    function GetOptions: TQueryParams;
    function GetRTDBPath: TStringDynArray;
    procedure FormCreate(Sender: TObject);
    function BitmapToBase64(Bitmap: Tbitmap): string;
    procedure Base64ToBitmap(AString: String; Result : Tbitmap);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btnLoginClick(Sender: TObject);
    procedure OnUserResponse(const Info: string;
  User: IFirebaseUser);
      procedure OnUserError(const Info, ErrMsg: string);
  procedure OnUserResp(const Info: string;
  Response: IFirebaseResponse);
    procedure lvCopiesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvCopiesItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure btnUpdateClick(Sender: TObject);
    function CheckAndCreateRealTimeDBClass(): boolean;
    function CheckSignedIn(Log: TMemo): boolean;
    procedure btnPasteClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    function ExistsInList(ListCopy: TList; valor: string ): boolean;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    fFirebaseEvent: IFirebaseEvent;
    fAuth: IFirebaseAuthentication;
    fRealTimeDB: IRealTimeDB;
    procedure ShowRTNode(ResourceParams: TRequestResourceParam; Val: TJSONValue);
  public
    { Public declarations }
  end;

  (*TCopyType = (Text, Image);

  TCopy = class(TObject)
  private
  protected
  public
    CreationDate: TDateTime;
    Description: String;
    Value: String;
    CopyType: TCopyType;

    constructor Create();
  end;*)

var
  TabbedForm: TTabbedForm;
  CopyList: TList;

implementation

{$R *.fmx}

function TTabbedForm.GetOptions: TQueryParams;
const
  sQuery = '"$%s"';
begin
  result := nil;
//  if (cboOrderBy.ItemIndex = 1) and (not edtColumName.Text.IsEmpty) then
//  begin
//    result := TQueryParams.Create;
//    result.Add(cGetQueryParamOrderBy, ['"' + edtColumName.Text + '"']);
//  end
//  else if cboOrderBy.ItemIndex > 1 then
//  begin
//    result := TQueryParams.Create;
//    result.Add(cGetQueryParamOrderBy,
//      [Format(sQuery, [cboOrderBy.Items[cboOrderBy.ItemIndex]])])
//  end;
//  if spbLimitToFirst.Value > 0 then
//  begin
//    if not assigned(result) then
//      result := TQueryParams.Create;
//    result.Add(cGetQueryParamLimitToFirst, [spbLimitToFirst.Value.toString]);
//  end;
//  if spbLimitToLast.Value > 0 then
//  begin
//    if not assigned(result) then
//      result := TQueryParams.Create;
//    result.Add(cGetQueryParamLimitToLast, [spbLimitToLast.Value.toString]);
//  end;
end;


function TTabbedForm.GetRTDBPath: TStringDynArray;
begin
  //result := SplitString('/muchmusic'.Replace('\', '/'), '/');
  result := SplitString('/muchcopy', '/');
end;

procedure TTabbedForm.btnLoginClick(Sender: TObject);
begin
//   CreateAuthenticationClass;
  //if edtEMail.Text.IsEmpty then
  //begin
  //  fAuth.SignInAnonymously(OnUserResponse, OnUserError);
  //  btnLinkEMailPwd.Visible := true;
  //  btnSignUpNewUser.Visible := false;
  //end else
  fAuth := TFirebaseAuthentication.Create('AIzaSyDWrIWO0K6lOMbxl2Cq6O2Hkb20glviRAU');
  try

    fAuth.SignInWithEmailAndPassword(txtUser.Text, txtPassword.Text,
      OnUserResponse, OnUserError);
//    fAuth.SignInWithEmailAndPasswordSynchronous(txtUser.Text, txtPassword.Text)//,
//      OnUserResponse, OnUserError);
      //fAuth.
  Except
    on E : Exception do
    memUser.Lines.Add('error' + E.Message);
  end;
     memUser.Lines.Add('token ' + fAuth.Token);
//     memUser.Lines.Add('expire at ' + fAuth.TokenExpiryDT);
end;


procedure TTabbedForm.OnUserResponse(const Info: string;
  User: IFirebaseUser);
begin
  memUser.Lines.Add(fAuth.Token);
  //memUser.Lines.Clear;
  //DisplayUser(memUser, User);
  //edtToken.Text := fAuth.Token;
  //edtUID.Text := User.UID;
  //lblTokenExp.Text := 'expires at ' + DateTimeToStr(fAuth.TokenExpiryDT);
  //btnRefresh.Enabled := false;
  //btnRefresh.Visible := fAuth.Authenticated;
  //btnPasswordReset.Visible := not fAuth.Authenticated;
  //timRefresh.Enabled := btnRefresh.Visible;
  //btnLogin.Visible := not User.IsNewSignupUser;
  //btnSignUpNewUser.Visible := User.IsNewSignupUser;
end;

procedure TTabbedForm.OnUserError(const Info, ErrMsg: string);
begin
  memUser.Lines.Add(Info + ' failed: ' + ErrMsg);
  ShowMessage(Info + ' failed: ' + ErrMsg);
end;

procedure TTabbedForm.OnUserResp(const Info: string;
  Response: IFirebaseResponse);
begin
  if Response.StatusOk then
    memUser.Lines.Add(Info + ' done')
//  else if not Response.ErrorMsg.IsEmpty then
  //  memUser.Lines.Add(Info + ' failed: ' + Response.ErrorMsg)
  else
    memUser.Lines.Add(Info + ' failed: ' + Response.StatusText);
end;

function TTabbedForm.CheckSignedIn(Log: TMemo): boolean;
begin
  if assigned(fAuth) and fAuth.Authenticated then
    result := true
  else begin
    Log.Lines.Add('Please sign in first!');
    Log.GoToTextEnd;
    result := false;
  end;
end;

//function TTabbedForm.CheckAndCreateRealTimeDBClass(Log: TMemo): boolean;
function TTabbedForm.CheckAndCreateRealTimeDBClass(): boolean;
begin
//  if not CheckSignedIn(Log) then
  //  exit(false);
  if not assigned(fRealTimeDB) then
  begin
//    fRealTimeDB := TRealTimeDB.Create('AIzaSyDWrIWO0K6lOMbxl2Cq6O2Hkb20glviRAU', fAuth);
    fRealTimeDB := TRealTimeDB.Create('muchcopy', fAuth);
    //edtProjectID.enabled := false;
    fFirebaseEvent := nil;
  end;
  result := true;
end;

function TTabbedForm.ExistsInList(ListCopy: TList; valor: string ): boolean;
var
  resultado: boolean;
  copyItem: TCopy;
  i: integer;
begin
  resultado := false;
  //for copyItem in TList do
//  for i := 0 to ListCopy.Count-1 do

  for i := 0 to lvCopies.Items.Count -1 do
  begin
    if lvCopies.Items[i].TagString = valor then
    begin
       resultado := true
    end;
  end;

  result := resultado;
end;

procedure TTabbedForm.btnPasteClick(Sender: TObject);
var
  Svc: IFMXClipboardService;
  Value: TValue;
  Image: TBitmap;
  lvItem : TListViewItem;
  AStream : TMemoryStream;
  copyItem: TCopy;
  Serializer: TJsonSerializer;
  valor: string;
begin
  if SupportsPlatformService(IFMXClipboardService, Svc) then
  begin
    Value := Svc.GetClipboard;
    if not Value.IsEmpty then
    begin

        if Value.IsType<string> then
        begin
          copyItem := TCopy.Create();
          copyItem.Date := now;
          copyItem.Description := 'Texto';
          valor := Value.ToString;
          copyItem.Value := valor;
          copyItem.CopyType := TCopyType.Text;
        end
        else if Value.IsType<TBitmapSurface> then
        try
          //PasteLabel.Text := string.Empty;
          Image := TBitmap.Create;
          try
            Image.Assign(Value.AsType<TBitmapSurface>);
            copyItem := TCopy.Create();
            copyItem.Date := now;
            copyItem.Description := 'Imagen';
            copyItem.Value := BitmapToBase64(Image);
            copyItem.CopyType := TCopyType.Bitmap;
          finally
            Image.Free;
          end;
        finally
          Value.AsType<TBitmapSurface>.Free;
        end;
        //todo arreglar esto de abajo
        if (ExistsInList(CopyList,copyItem.Value) = false) then
        begin
          CopyList.Add(copyItem);
          lvItem := lvCopies.Items.Add;
          lvItem.BeginUpdate;

          if copyItem.CopyType = TCopyType.Text then
          begin
            lvItem.Detail := 'texto';
            lvItem.TagString := Value.ToString;
            lvItem.Text := Value.ToString;
          end
          else
          begin
            lvItem.Detail := 'bitmap';
            //TListItemImage(lvItem.Objects.FindDrawable('Imp1')).Bitmap.Assign(Image); //
            lvItem.Bitmap := Image;
            lvItem.TagString := copyItem.Value;
            lvItem.Text := Value.ToString;
          end;
          //lvItem.Text := copyItem.Value;
          lvItem.ButtonText := Value.ToString;;
          lvItem.EndUpdate;

        end;
      //memUser.Text := TJson.ObjectToJsonString(copyItem);
      Serializer := TJsonSerializer.Create;
      try
        memUser.Lines.Add( Serializer.Serialize(copyItem));
      finally
        Serializer.Free;
      end;

    end;
  end;
end;

function TTabbedForm.BitmapToBase64(Bitmap: Tbitmap): string;
var
BS: TBitmapSurface;
AStream: TMemoryStream;
begin
  BS := TBitmapSurface.Create;
  BS.Assign(Bitmap);
  BS.SetSize(300, 200);
  AStream := TMemoryStream.Create;
  try
  TBitmapCodecManager.SaveToStream(AStream, BS, '.png');
  Result := TNetEncoding.Base64.EncodeBytesToString(AStream.Memory, AStream.Size);
  finally
  AStream.Free;
  BS.Free;
  end;
end;

procedure TTabbedForm.Base64ToBitmap(AString: String; Result : Tbitmap);
var
ms : TMemoryStream;
BS: TBitmapSurface;
bytes : TBytes;
begin
  bytes := TNetEncoding.Base64.DecodeStringToBytes(AString);
  ms := TMemoryStream.Create;
  try
  ms.WriteData(bytes, Length(bytes));
  ms.Position := 0;
  BS := TBitmapSurface.Create;
  BS.SetSize(300, 200);
  try
  TBitmapCodecManager.LoadFromStream(ms, bs);
  Result.Assign(bs);
  finally
  BS.Free;
  end;
  finally
  ms.Free;
  end;
end;

(*procedure TTabbedForm.CopyButtonClick(Sender: TObject);
var
  Svc: IFMXClipboardService;
  Image: TBitmap;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    if TextRadioButton.IsChecked then
      Svc.SetClipboard(Edit1.Text)
    else
    begin
      Image := TextBorder.MakeScreenshot;
      try
        Svc.SetClipboard(Image);
      finally
        Image.Free;
      end;
    end;
end;
  *)
(*procedure TTabbedForm.PasteButtonClick(Sender: TObject);
var
  Svc: IFMXClipboardService;
  Value: TValue;
  Bitmap: TBitmap;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
  begin
    Value := Svc.GetClipboard;
    if not Value.IsEmpty then
    begin
      if Value.IsType<string> then
      begin
        PasteLabel.Text := Value.ToString;
        PasteImage.Bitmap := nil;
      end
      else if Value.IsType<TBitmapSurface> then
      try
        PasteLabel.Text := string.Empty;
        Bitmap := TBitmap.Create;
        try
          Bitmap.Assign(Value.AsType<TBitmapSurface>);
          PasteImage.Bitmap := Bitmap;
        finally
          Bitmap.Free;
        end;
      finally
        Value.AsType<TBitmapSurface>.Free;
      end;
    end;
  end;
end;
  *)
procedure TTabbedForm.btnUpdateClick(Sender: TObject);
var
  Val: TJSONValue;
  Val2: TJSONValue;
  Query: TQueryParams;
  fireBase: TStringDynArray;
  ValS: String;
begin
  if not CheckAndCreateRealTimeDBClass() then
    exit;
  try
    Query := GetOptions;
    try
      fireBase := SplitString('/muchcopy', '/');
      Val := fRealTimeDB.GetSynchronous(GetRTDBPath(), Query);
      try
        //obtiene el valor de firebase
        ShowRTNode(fireBase, Val);
      finally
        Val.Free;
      end;
    finally
      Query.Free;
    end;
  except
    on e: exception do
      ShowMessage(e.Message);
  end;
end;

procedure TTabbedForm.btnUploadClick(Sender: TObject);
begin
  PutRTSynchClick();
end;

procedure TTabbedForm.Button1Click(Sender: TObject);
var
  jsArray: TJSONArray;
begin
  jsArray :=TJSONObject.ParseJSONValue(txtTest.Text) as TJSONArray;
  ShowMessage(jsArray.ToString);
end;

procedure TTabbedForm.PutRTSynchClick();
var
  Data: TJSONObject;
  DataItem: TJSONObject;
  DataItem2: TJSONObject;
  Val: TJSONValue;
  c: integer;
  Serializer: TJsonSerializer;
  serial: String;
  fireBase: TStringDynArray;
  jsArray: TJSONArray;
  FoundValue: TJSonValue;
  i: integer;
  auxstr: string;
  strItem: string;
  strItem2: string;
begin
//todo pasar todo a list<algo>
   if not CheckAndCreateRealTimeDBClass() then
    exit;
  //if lstDBNode.Items.Count = 0 thenu

  begin
    //memRTDB.Lines.Add('Add first elements to the node');
    //exit;
  end;
  Data := TJSONObject.Create;
  //DataItem := TJSONObject.Create;
  strItem2:= '{"id":"0","tipo":"texto","valor":"colussi52.com"}';
  DataItem2 := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(strItem2), 0) as TJSONObject;
  Val := nil;
  try
    Serializer := TJsonSerializer.Create();
    i := 1;
    for c := 0 to lvCopies.Items.Count - 1 do
    begin
       strItem := Concat('{"id":"',c.ToString,'","tipo":"',lvCopies.Items[c].Detail ,
       '","valor":"',lvCopies.Items[c].TagString,'"}');
      (*DataItem.AddPair('id',c.ToString);
      DataItem.AddPair('tipo',lvCopies.Items[c].Detail);
      DataItem.AddPair('valor',lvCopies.Items[c].TagString);*)
      memUser.Lines.Add('item: ----> ' + strItem);
      DataItem := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(strItem), 0) as TJSONObject;
      Data.AddPair(c.ToString,DataItem);
    end;
    Data.AddPair('addd',DataItem2);
    //Data.AddPair('1',DataItem.ToString);
    //memRTDB.Lines.Clear;
    try
      fireBase := SplitString('/muchcopy', '/');
      ShowMessage(data.ToString);
      memUser.Lines.Add('Data: ----> ' + data.ToString);
      auxstr := data.ToString;

      ShowMessage(auxstr);
      //auxstr := data.GetValue('0').ToString;
      ShowMessage(auxstr);

      Val := fRealTimeDB.PutSynchronous(fireBase,data );
      //ShowRTNode(fireBase, Val);
      memUser.Lines.Add('Upload: ' + Val.ToString);
    except
      on e: exception do
      memUser.Lines.Add(e.Message);
    end;
  except
      on e: exception do
      begin
        memUser.Lines.Add(e.Message);
        Val.Free;
        Data.Free;
      end;
  end;
end;



procedure TTabbedForm.ShowRTNode(ResourceParams: TRequestResourceParam;
  Val: TJSONValue);
var
  Obj: TJSONObject;
  c: integer;
  i: integer;
  valores: TJSONArray;
  valores2: TJSONArray;
  valor: TJSONObject;
  ArrayElement: TJsonValue;
  FoundValue: TJsonValue;
  sValor: string;
  item: string;
  varvar: TJSONObject;
  auxstr: string;
  campo1: string;
begin
  try
    if Val is TJSONObject then
    begin
      memUser.Lines.Add('Comienzo Download');
      Obj := Val as TJSONObject;
      for c := 0 to Obj.Count - 1 do
      begin
        if Obj.Pairs[c].JsonValue is TJSONString then
        begin
          memUser.Lines.Add(Obj.Pairs[c].JsonString.Value + ': ' +
            Obj.Pairs[c].JsonValue.ToString) ;
          memUser.Lines.Add(Obj.GetValue('valor').ToString);
        end
        else
        begin
          memUser.Lines.Add(Obj.Pairs[c].JsonString.Value + ': ' +
            Obj.Pairs[c].JsonValue.ToJSON);
          memUser.Lines.Add(Obj.Pairs[c].JsonValue.FindValue('valor').ToJSON);
        end;
      end;
    end
    else if not(Val is TJSONNull) then
    begin

      try
      //valor := TJSONObject.TJSONParseOptions
      valores := TJSONObject.ParseJSONValue(Val.ToString) as TJSONArray;
      memUser.Lines.Add('----');
      memUser.Lines.Add(Val.ToString);
      memUser.Lines.Add(valores.ToString);
      valores2 := Val as TJSONArray;
      for ArrayElement in valores do
      begin
        //FoundValue := ArrayElement.GetValue<String>('id');
         //valor := TJsonObject.ParseJSONValue(ArrayElement.ToString) ;
         if ArrayElement <> nil then
         begin
          memUser.Lines.Add('----ArrayElement.ToString');
          memUser.Lines.Add(ArrayElement.ToString);
          //writeln(ArrayElement.ToString);
          memUser.Lines.Add('----');
          //ShowMessage(ArrayElement.ToString());
          //sValor := ArrayElement.TryGetValue('valor',sValor).ToString;//TJsonObject(ArrayElement.ToString).Values['valor'].ToString;
           //valor := TJsonObject.ParseJSONValue(auxstr) as TJSONObject;
           //valor.GetValue('valor',sValor);//TJsonObject(ArrayElement.ToString).Values['valor'].ToString;
           //ShowMessage(valor.ToString);
          if ArrayElement.ToString <> 'null' then
          begin
            //valores2 := TJSONObject.ParseJSONValue(ArrayElement.ToString) as TJSONArray;
            auxstr := ArrayElement.ToString.Replace('\','');
            varvar := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(auxstr), 0) as TJSONObject;;
            campo1 := varvar.GetValue('valor').Value;
            ShowMessage(campo1);
            //memUser.Lines.Add(auxstr.ToString);
            (*for varvar in valores2 as TJSONArray do
            begin
               ShowMessage(varvar.ToString);
            end;*)
             //valores2 := TJSONObject.ParseJSONValue(ArrayElement.ToString) as TJSONArray;
            //valor := TJsonObject. (ArrayElement) as TJSONObject;
            //memUser.Lines.Add(ArrayElement.GetValue<string>('valor'));
          end;
         end;
      end;
      (*for i := 0 to valores.Size - 1 do
      begin
        //item := valores[i];
//        valor := TJSONObject.ParseJSONValue(item);
//        memUser.Lines.Add(valor.ToString);
        //CarName := Car.Get('name').JsonValue.Value;
      end;*)
      Except
        on E: Exception do
          ShowMessage(E.Message);
      end;
        valores.Free;
      //end;
      //memUser.Lines.Add(Val.ToString);
      memUser.Lines.Add('Fin Download');
      //memUser.Lines.Add('Comienzo Parseo');

    end
    else
      memUser.Lines.Add('path %s' + Val.ToString);
      //Format('Path %s not found'));
      //,[GetPathFromResParams(ResourceParams)]
      //));
  except
    on e: exception do
      ShowMessage(e.Message);

      //memRTDB.Lines.Add('Show RT Node failed: ' + e.Message);
  end
end;


procedure TTabbedForm.FormCreate(Sender: TObject);
var
  item : TListItem;
  lvItem : TListViewItem;
  lvItem2 : TListViewItem;
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
  CopyList := TList.Create();
  btnLoginClick(Self);
  //
(*  try
    lvItem := lvCopies.Items.Add;
    lvItem.BeginUpdate;
    lvItem.Detail := 'Test1 ';
    lvItem.Text := 'Prueba 1';
    lvItem.ButtonText := 'prueba';
    lvItem.EndUpdate;

    lvItem2 := lvCopies.Items.Add;
    lvItem2.BeginUpdate;
    lvItem2.Detail := 'Test1 ';
    lvItem2.Text := 'Prueba 2';
    lvItem2.EndUpdate;


  Except
    on E : Exception do
    memUser.Lines.Add('error' + E.Message);
  end;*)
end;

procedure TTabbedForm.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
{$IFDEF ANDROID}
  case EventInfo.GestureID of
    sgiLeft:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount-1] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex+1];
      Handled := True;
    end;

    sgiRight:
    begin
      if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
        TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex-1];
      Handled := True;
    end;
  end;
{$ENDIF}
end;

procedure TTabbedForm.lvCopiesItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  //showmessage('itemclick ' + AItem.Index.ToString());
end;

procedure TTabbedForm.lvCopiesItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  //showmessage('ex' + IntToStr(ItemIndex));
  // ItemObject.Name is the name of the oject that is clicked in the ListView row.

//If just looking for type of object:
if ItemObject is TListItemAccessory then ShowMessage('Acessory clicked');

if ItemObject is TListItemImage then ShowMessage('Image clicked: ' + ItemObject.Name);

if ItemObject is TListItemText then ShowMessage('text clicked');
end;

end.
