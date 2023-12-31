--------------------------------------------------------
--  Agregar campos usados en MySQL a tabla INFOX_SESSION
--------------------------------------------------------

  ALTER TABLE "DBAPER"."INFOX_SESSION" 
   ADD ("ESTATUS" NUMBER(3,0), 
	"ORIGEN" VARCHAR2(20 BYTE), 
	"CANAL" VARCHAR2(50 BYTE), 
	"USUARIO_WS" VARCHAR2(50 BYTE), 
	"ES_SOLO_PBS" CHAR(1 BYTE) DEFAULT 'N', 
	"ES_PSS_PAQUETE" CHAR(1 BYTE) DEFAULT 'N', 
	"API_KEY" VARCHAR2(40 BYTE), 
	"TOKEN" VARCHAR2(1100 BYTE), 
	"NUMSESSION_ORIGEN" NUMBER(12,0), 
	"TIENE_EXCESOPORGRUPO" CHAR(1 BYTE) DEFAULT 'N'
   ) ;

   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."ESTATUS" IS 'C�digo de Estatus de la Autorizaci�n en el ciclo de vida de la Sesi�n';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."ORIGEN" IS '(ARS, ASE) Es una abreviatura para la Compa��a Or�gen del Asegurado (Primera o Humano). Este campo se eliminar� en una refactorizaci�n posterior';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."CANAL" IS 'Canal a trav�s del cual se realiza esta sesi�n (WEBSALUD, FONOSALUD, WEBSERVICE, KIOSKO,�)';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."USUARIO_WS" IS 'Nombre de usuario del webservice otorgado al prestador que cre� esta sesi�n';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."ES_SOLO_PBS" IS 'Indica si el asegurado de esta sesi�n �nicamente posee plan b�sico';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."ES_PSS_PAQUETE" IS 'Indica si el prestador pertenece a un paquete';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."API_KEY" IS 'Api Key asignado al prestador que cre� esta sesi�n. Se remueve al cerrar sesi�n o reactivar sesiones';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."TOKEN" IS 'Token generado por el servicio de autenticaci�n para autorizar esta sesi�n.';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."NUMSESSION_ORIGEN" IS 'N�mero de sesi�n original, si esta es una sesi�n reactivada.';
   COMMENT ON COLUMN "DBAPER"."INFOX_SESSION"."TIENE_EXCESOPORGRUPO" IS 'Indica si el asegurado Excede el Monto de Beneficio por Grupo para la �ltima cobertura validada. Se pone en NULL al final de p_insertcobertura';

--------------------------------------------------------
--  Constraints for Table INFOX_SESSION
--------------------------------------------------------

  ALTER TABLE "DBAPER"."INFOX_SESSION" ADD CONSTRAINT "CHK_INFOX_SESSION_EXCPORGRUPO" CHECK (TIENE_EXCESOPORGRUPO IN ('S', 'N') ) ENABLE;
  ALTER TABLE "DBAPER"."INFOX_SESSION" ADD CONSTRAINT "CHK_INFOX_SESSION_ES_PSS_PAQ" CHECK (ES_PSS_PAQUETE IN ('S', 'N') ) ENABLE;
  ALTER TABLE "DBAPER"."INFOX_SESSION" ADD CONSTRAINT "CHK_INFOX_SESSION_EST" CHECK (ES_SOLO_PBS IN ('S', 'N') ) ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table INFOX_SESSION
--------------------------------------------------------

  ALTER TABLE "DBAPER"."INFOX_SESSION" ADD CONSTRAINT "INFOX_SESSION_EST_FK" FOREIGN KEY ("ESTATUS")
	  REFERENCES "DBAPER"."ESTATUS" ("CODIGO") ENABLE;
  ALTER TABLE "DBAPER"."INFOX_SESSION" ADD CONSTRAINT "INFOX_SESSION_NUMSESS_FK" FOREIGN KEY ("NUMSESSION_ORIGEN")
	  REFERENCES "DBAPER"."INFOX_SESSION" ("NUMSESSION") ENABLE;