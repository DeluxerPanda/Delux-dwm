/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = {"JetBrains Mono:size=11", "JoyPixels:pixelsize=11:antialias=true:autohint=true"};
static const char dmenufont[]       = "JetBrains Mono:size=11";
static char normbgcolor[]           = "#2C2C2C"; //Black
static char normbordercolor[]       = "#2C2C2C"; //Black
static char normfgcolor[]           = "#FFFFFF"; //White
static char selfgcolor[]            = "#FFFFFF"; //White
static char selbordercolor[]        = "#FCF434"; //Yellow
static char selbgcolor[]            = "#9C59D1";//Purple
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

/* tagging */
static const char *tags[] = { "1", "2"," 3", "4", "5", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "steam",              NULL,     NULL,           1 << 5,         1,          0,           0,        -1 },
	{ "St",                 NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ NULL,                 NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *roficmd[] = { "rofi", "-show", "drun", "-show-icons", NULL };
static const char *termcmd[]  = { "st", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_Right,  setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Tab,    focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Left,   setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_f,      togglebar,      {0} },
	{ MODKEY,                       XK_j,	   zoom,           {0} },
	{ MODKEY,		        XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_space,  spawn,          {.v = roficmd } },
	{ MODKEY,			XK_Return, spawn,          {.v = termcmd } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	{ MODKEY|ShiftMask,		XK_q,      quit,           {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_r,      spawn,          SHCMD("systemctl reboot")},
	{ MODKEY|ControlMask|ShiftMask, XK_s,      spawn,          SHCMD("shutdown now")},
};
static const char *mutevolcmd[] = { "amixer", "-D", "pulse", "sset", "Master", "toggle", NULL };
static const char *volupcmd[] = { "amixer", "-D", "pulse", "sset", "Master", "1%+", NULL };
static const char *voldowncmd[] = { "amixer", "-D", "pulse", "sset", "Master", "1%-", NULL };

static Button buttons[] = {
    // ...
    { ClkTagBar, 0, Button1, spawn, {.v = voldowncmd } },
    { ClkTagBar, 0, Button2, spawn, {.v = volupcmd } },
    { ClkTagBar, 0, Button3, spawn, {.v = mutevolcmd } },
    // ...
};
