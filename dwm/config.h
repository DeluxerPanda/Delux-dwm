/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int refresh_rate    = 60;     /* matches dwm's mouse event processing to your monitor's refresh rate for smoother window interactions */
static const unsigned int enable_noborder = 1;      /* toggles noborder feature (0=disabled, 1=enabled) */
static const unsigned int borderpx        = 1;      /* border pixel of windows */
static const unsigned int snap            = 26;     /* snap pixel */
static const int swallowfloating          = 1;      /* 1 means swallow floating windows by default */
static const unsigned int systraypinning  = 0;      /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft   = 0;      /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing  = 5;      /* systray spacing */
static const int systraypinningfailfirst  = 1;      /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray              = 1;      /* 0 means no systray */
static const int showbar                  = 1;      /* 0 means no bar */
static const int topbar                   = 1;      /* 0 means bottom bar */
#define ICONSIZE                            17      /* icon size */
#define ICONSPACING                         5       /* space between icon and title */
#define SHOWWINICON                         1       /* 0 means no winicon */
static const char *fonts[]                = { "JetBrainsMonoNL Nerd Font Mono:size=16", "NotoColorEmoji:pixelsize=16:antialias=true:autohint=true"  };
static const char normbordercolor[]       = "#1b1311"; /*#3B4252 röd*/
static const char normbgcolor[]           = "#010409"; /*workspaces bar and button background*/
static const char normfgcolor[]           = "#313244"; /*workspaces button and layouts */
static const char selbordercolor[]        = "#010409"; /*bar background*/
static const char selbgcolor[]            = "#010409";/*workspaces bar and button active background*/
static const char selfgcolor[]            = "#cba6f7"; /*workspaces button active and slstatus*/

static const char *colors[][3]      = {
											/*fg                   bg                   border */
	[SchemeSlstatus] = { selfgcolor, normbgcolor, normbordercolor },
	[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
	[SchemeSel] =  { selfgcolor,  selbgcolor,  selbordercolor },
};

static const char *const autostart[] = {
  "xset", "s", "off", NULL,
  "xset", "s", "noblank", NULL,
  "xset", "-dpms", NULL,
  "flameshot", NULL,
  "goxlr-launcher", NULL,
  "picom", "--animations", "-b", NULL,
  "bash", "/home/deluxerpanda/.screenlayout/default.sh", NULL,
  "sh", "-c", "feh --randomize --bg-fill $HOME/Bilder/backgrounds/*", NULL,
  "slstatus", NULL,
  NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const char ptagf[] = "[%s %s]";  /* format of a tag label */
static const char etagf[] = "[%s]";     /* format of an empty tag */
static const int lcaselbl = 0;          /* 1 means make tag label lowercase */

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "St",      NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ "kitty",   NULL,     NULL,           0,         0,          1,           0,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.75; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      tile },    /* first entry is default */
	{ "",      NULL },    /* no layout function means floating behavior */
	{ "",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define STATUSBAR "dwmblocks"
/* commands */
static const char *launchercmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { "kitty", NULL };



static Key keys[] = {
	/*modifier             key              function        argument */
	 { MODKEY,        XK_r,          spawn,                  {.v = launchercmd} }, // spawn rofi
	 { MODKEY,        XK_x,          spawn,                  {.v = termcmd } }, // spawn a terminal
	{ MODKEY,         XK_b,         spawn,         SHCMD ("xdg-open https://")}, 	// open default browsers
	{ MODKEY,         XK_e,         spawn,         SHCMD ("dolphin")},	// open dolphin file manager
	{ MODKEY,         XK_w,         spawn,         SHCMD ("looking-glass-client -F")},	// start Looking glass
	{ 0,                        0x1008ff11,spawn,         SHCMD("amixer sset Master 5%") },	// Decrease volume by 5%
	{ 0,                        0x1008ff13,spawn,         SHCMD("amixer sset Master 5%") },	// Increase volume by 5%
	{ MODKEY,         XK_d,       incnmaster,         {.i = -1 } }, // increase the number of clients in the master area
	{ MODKEY,         XK_h,         setmfact,         {.f = -0.05} }, // decrease the size of the master area compared to the stack area(s)
	{ MODKEY,         XK_l,          setmfact,               {.f = +0.05} }, // increase the size of the master area compared to the stack area(s)
	{ MODKEY,         XK_j ,          zoom,         {0} }, // moves the currently focused window to/from the master area (for tiled layouts)
	{ MODKEY,         XK_q,         killclient,         {0} }, // close the currently focused window
	{ MODKEY,         XK_t,          setlayout,         {.v = &layouts[0]} }, // set tile layout
    { MODKEY,         XK_Tab,    zoom,               {0} }, // moves the currently focused window to/from the master area (for tiled layouts)
	{ MODKEY,         XK_f,        fullscreen,         {0} }, // toggles fullscreen for the currently selected client
	{ MODKEY|ShiftMask,         XK_b,         togglebar, {0} }, 	// toggle bar visibility
	{ MODKEY|ShiftMask,         XK_Tab,    tagmon,          {.i = +1 } }, // tag next monitor
// { MODKEY|ShiftMask,         XK_Tab,     focusmon,               {.i = +1 } }, // focus on the next monitor, if any

    { MODKEY|ControlMask,           XK_q,          spawn,                  SHCMD("$HOME/.config/rofi/powermenu.sh")}, // exit dwm

	{ MODKEY|ControlMask|ShiftMask,        XK_q,        quit,        {0} }, // exit dwm
	{ MODKEY|ControlMask|ShiftMask,        XK_r,        spawn,        SHCMD("systemctl reboot")}, // reboot system
	{ MODKEY|ControlMask|ShiftMask,        XK_s,        spawn,        SHCMD("systemctl suspend")}, // suspend system

	TAGKEYS(                                                                 XK_1,                                  0)
	TAGKEYS(                                                                 XK_2,                                  1)
	TAGKEYS(                                                                 XK_3,                                  2)
	TAGKEYS(                                                                 XK_4,                                  3)
	TAGKEYS(                                                                 XK_5,                                  4)
};


/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkClientWin,         MODKEY,         Button1,        moveorplace,    {.i = 2} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
