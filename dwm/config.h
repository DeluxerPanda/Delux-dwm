/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int refresh_rate    = 60;     /* matches dwm's mouse event processing to your monitor's refresh rate for smoother window interactions */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 26;       /* snap pixel */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 5;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray             = 1;   /* 0 means no systray */
//static const unsigned int baralpha = 0xd0;
//static const unsigned int borderalpha = OPAQUE;
static const unsigned int baralpha = 0x80;  // More transparent bar
static const unsigned int borderalpha = 0x80;  // More transparent borders
#define ICONSIZE 17   /* icon size */
#define ICONSPACING 5 /* space between icon and title */
static const char *fonts[]                = { "JetBrainsMonoNL Nerd Font Mono:size=16", "NotoColorEmoji:pixelsize=16:antialias=true:autohint=true"  };
static const char col_bg[]       = "#222222";
static const char col_sel[]       = "#cba6f7";
static const char col_text[]       = "#ffffff";
static const char col_cyan[]        = "#00FFFF";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_text, col_bg, col_cyan },
	[SchemeSel]  = { col_sel, col_bg,  col_cyan  },
};


static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
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

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",    NULL,     NULL,           0,         1,          0,           0,        -1 },
	{ "Firefox", NULL,     NULL,           1 << 8,    0,          0,          -1,        -1 },
	{ "kitty",      NULL,     NULL,           0,         0,          1,           0,        -1 },
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

/* commands */
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { "kitty", NULL };

static Key keys[] = {
	/*modifier             key              function        argument */
	{ MODKEY,         XK_r,           spawn,         {.v = dmenucmd} },
	{ MODKEY,         XK_x,          spawn,         {.v = termcmd } },
	{ MODKEY,         XK_b,          spawn,         SHCMD ("xdg-open https://")},
	{ MODKEY,         XK_e,          spawn,         SHCMD ("dolphin")},
	{ MODKEY,         XK_w,         spawn,         SHCMD ("looking-glass-client -F")},
	{ MODKEY,         XK_h,          setmfact,      {.f = -0.05} },
	{ MODKEY,         XK_l,           setmfact,      {.f = +0.05} },
	{ MODKEY,         XK_q,          killclient,       {0} },
	{ MODKEY,         XK_t,           setlayout,     {.v = &layouts[0]} },
	{ MODKEY,         XK_Tab,      zoom,          {0} },
	{ MODKEY,         XK_f,           fullscreen,   {0} },

	{ 0,                      0x1008ff11, spawn,        SHCMD("amixer sset Master 5%") },
	{ 0,                      0x1008ff13, spawn,        SHCMD("amixer sset Master 5%") },

	{ MODKEY|ShiftMask,XK_b,  togglebar,     {0} },
	{ MODKEY|ShiftMask,XK_Tab,tagmon,      {.i = +1 } },

	{ MODKEY|ControlMask,XK_q,spawn,       SHCMD("$HOME/.config/rofi/powermenu.sh")},

	{ MODKEY|ControlMask|ShiftMask,XK_q,quit,{0} },
	{ MODKEY|ControlMask|ShiftMask,XK_r,spawn,SHCMD("systemctl reboot")},
	{ MODKEY|ControlMask|ShiftMask,XK_s,spawn,SHCMD("systemctl suspend")},

	TAGKEYS(          XK_1,                               0)
	TAGKEYS(          XK_2,                               1)
	TAGKEYS(          XK_3,                               2)
	TAGKEYS(          XK_4,                               3)
	TAGKEYS(          XK_5,                               4)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkClientWin, MODKEY,       Button1,       moveorplace,{.i = 2} },
	{ ClkTagBar,     0,                       Button1,       view,            {0} },
};
