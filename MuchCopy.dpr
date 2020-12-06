program MuchCopy;

uses
  System.StartUpCopy,
  FMX.Forms,
  TabbedTemplate in 'TabbedTemplate.pas' {TabbedForm},
  FB4D.Authentication in 'Source\FB4D.Authentication.pas',
  FB4D.Configuration in 'Source\FB4D.Configuration.pas',
  FB4D.Document in 'Source\FB4D.Document.pas',
  FB4D.Firestore in 'Source\FB4D.Firestore.pas',
  FB4D.Functions in 'Source\FB4D.Functions.pas',
  FB4D.Helpers in 'Source\FB4D.Helpers.pas',
  FB4D.Interfaces in 'Source\FB4D.Interfaces.pas',
  FB4D.OAuth in 'Source\FB4D.OAuth.pas',
  FB4D.RealTimeDB in 'Source\FB4D.RealTimeDB.pas',
  FB4D.Request in 'Source\FB4D.Request.pas',
  FB4D.Response in 'Source\FB4D.Response.pas',
  FB4D.Storage in 'Source\FB4D.Storage.pas',
  JOSE.Builder in 'Source\JOSE\JOSE.Builder.pas',
  JOSE.Consumer in 'Source\JOSE\JOSE.Consumer.pas',
  JOSE.Consumer.Validators in 'Source\JOSE\JOSE.Consumer.Validators.pas',
  JOSE.Context in 'Source\JOSE\JOSE.Context.pas',
  JOSE.Core.Base in 'Source\JOSE\JOSE.Core.Base.pas',
  JOSE.Core.Builder in 'Source\JOSE\JOSE.Core.Builder.pas',
  JOSE.Core.JWA.Compression in 'Source\JOSE\JOSE.Core.JWA.Compression.pas',
  JOSE.Core.JWA.Encryption in 'Source\JOSE\JOSE.Core.JWA.Encryption.pas',
  JOSE.Core.JWA.Factory in 'Source\JOSE\JOSE.Core.JWA.Factory.pas',
  JOSE.Core.JWA in 'Source\JOSE\JOSE.Core.JWA.pas',
  JOSE.Core.JWA.Signing in 'Source\JOSE\JOSE.Core.JWA.Signing.pas',
  JOSE.Core.JWE in 'Source\JOSE\JOSE.Core.JWE.pas',
  JOSE.Core.JWK in 'Source\JOSE\JOSE.Core.JWK.pas',
  JOSE.Core.JWS in 'Source\JOSE\JOSE.Core.JWS.pas',
  JOSE.Core.JWT in 'Source\JOSE\JOSE.Core.JWT.pas',
  JOSE.Core.Parts in 'Source\JOSE\JOSE.Core.Parts.pas',
  JOSE.Encoding.Base64 in 'Source\Common\JOSE.Encoding.Base64.pas',
  JOSE.Hashing.HMAC in 'Source\Common\JOSE.Hashing.HMAC.pas',
  JOSE.Signing.RSA in 'Source\Common\JOSE.Signing.RSA.pas',
  JOSE.Types.Arrays in 'Source\Common\JOSE.Types.Arrays.pas',
  JOSE.Types.Bytes in 'Source\Common\JOSE.Types.Bytes.pas',
  JOSE.Types.JSON in 'Source\Common\JOSE.Types.JSON.pas',
  Umcopy in 'Umcopy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabbedForm, TabbedForm);
  Application.Run;
end.
