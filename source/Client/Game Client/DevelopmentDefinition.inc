{$DEFINE DEVELOP_MODE}
{*$DEFINE DEVELOP_INGAME}

(* Language Checking  *)

{$DEFINE CHECK_LANG}

{$IFDEF DEVELOP_MODE}
  {$IFDEF CHECK_LANG}
    {$DEFINE TEST_LANGUAGE_FILE}
    {$DEFINE CHECK_ENGLISH}
    {*$DEFINE CHECK_GERMAN}
    {*$DEFINE CHECK_POLISH}
    {*$DEFINE CHECK_SPANISH}
  {$ENDIF}
{$ENDIF}


(* Get Performance of sticked functions *)

{*$DEFINE DEVELOP_PERFORMANCE_COUNTER}

{Set Reseloution}
{*$DEFINE DEVELOP_1024x768}

{Show FPS in all Scenes}
{$DEFINE DEVELOP_SHOW_FPS}

(* Set Using Texture Lib*)
{*$DEFINE DEVELOP_LMT}
{*$DEFINE DEVELOP_WIL_2} //for later if LMT not good fast (include Wil and Wix in one file)
