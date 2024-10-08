/* ==UserStyle==
@name         Dark-Instagram
@namespace    gitlab.com/vednoc/dark-instagram
@description  Customizable dark and light theme for Instagram.
@author       vednoc <vednoc@pm.me> (https://gitlab.com/vednoc)
@homepageURL  https://gitlab.com/vednoc/dark-instagram
@supportURL   https://gitlab.com/vednoc/dark-instagram/issues
@updateURL    https://userstyles.world/api/style/30.user.css
@preprocessor stylus
@version      2.9.1
@license      MIT

@var text     ui_font       'Custom UI font' '"font_name"'
@var text     emoji_font    'Custom emoji font' '"font_name"'
@var checkbox ic_invert     'Enable icon inversion in dark mode' 1
@var checkbox enable_cm_s   'Enable right-click context menu in stories' 1
@var checkbox enable_cm_p   'Enable right-click context menu in posts' 1
@var checkbox enable_la     'Enable removal of logged-out annoyances' 1
@var checkbox sb_width      'Scrollbar thin width' 1
@var select   sb_color      'Scrollbar colors' {
    'None         ': 'none',
    'Old default  ': 'old',
    'With accent *': 'new',
}

@var color    _dark      'Color: Primary background   ' #1f232a
@var color    _darken    'Color: Highlight background ' #252A33
@var color    _darker    'Color: Secondary background ' #333943
@var color    _light     'Color: Primary foreground   ' #e9e9e9
@var color    _lighter   'Color: Secondary foreground ' #a1a1a1
@var color    _accent    'Color: Accent               ' #7289da
@var color    _yellow    'Color: Yellow               ' #e5c512
@var color    _orange    'Color: Orange               ' #df4b16
@var color    _red       'Color: Red                  ' #dc322f
@var color    _magenta   'Color: Magenta              ' #f33682
@var color    _violet    'Color: Violet               ' #6c71c4
@var color    _blue      'Color: Blue                 ' #268bd2
@var color    _cyan      'Color: Cyan                 ' #2aa198
@var color    _green     'Color: Green                ' #859900
@var color    _white     'Color: White                ' #ffffff
@var color    _shadow    'Color: Shadow               ' #00000025
==/UserStyle== */

i       = !important
vendors = official

// Color mixin.
/// All colors: `c: fg1 bg5 bg1`
/// Only border-color: `c: 0 bg5`
c(x, y = 0, z = 0, xi = 1, yi = 1, zi = 1) {
    if x != 0 && x != '_' {            color: xi is 0 ? x : x i }
    if y != 0 && y != '_' {     border-color: yi is 0 ? y : y i }
    if z != 0 && z != '_' { background-color: zi is 0 ? z : z i }
}

// SVG colors.
v(x, y = 0, xi = 1, yi = 1) {
    if x != 0 && x != '_' {   fill: xi is 0 ? x : x i }
    if y != 0 && x != '_' { stroke: yi is 0 ? y : y i }
}

// HACK: Convert HEX to RGB.
to_rgb(input) {
    unquote(slice(s('%s', rgba(input, 0)), 5, -3))
}

// Border radius mixin.
rad() { border-radius: arguments }

@-moz-document regexp('^https?://(www\.)?instagram\.com(/.*)?$') {
    note ?= 'Switching @updateURL to https://userstyles.world platform!\A\A'
    note += '🌚 Dark-Instagram v2.9.1'

    /// Theme variables.
    :root {
        --note      : note
        --bshadow   : 0 2px 4px var(--shadow);
        --t         : transparent i
        --avatar    : a_radius;
        --ui-font   : ui_font, -apple-system, BlinkMacSystemFont, 'Segoe UI',
            Roboto, Helvetica, Arial, Ubuntu, Cantarell, 'Noto Sans',
            var(--emoji-font), sans-serif;
        --emoji-font: emoji_font, 'joypixels', 'Apple Color Emoji',
            'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
        --white     : _white;
        --dark      : _dark;
        --darken    : _darken;
        --darker    : _darker;
        --light     : _light;
        --lighter   : _lighter;
        --accent    : _accent;
        --shadow    : _shadow;
        --yellow    : _yellow;
        --orange    : _orange;
        --red       : _red;
        --magenta   : _magenta;
        --violet    : _violet;
        --blue      : _blue;
        --cyan      : _cyan;
        --green     : _green;

        /// RGB variables.
        --dark-rgb:    to_rgb(_dark);
        --darken-rgb:  to_rgb(_darken);
        --darker-rgb:  to_rgb(_darker);
        --light-rgb:   to_rgb(_light);
        --lighter-rgb: to_rgb(_lighter);
        --accent-rgb:  to_rgb(_accent);
        --shadow-rgb:  to_rgb(_shadow);
        --white-rgb:   to_rgb(_white);

        /// Instagram variables.
        --b6a: var(--darker-rgb);     /// Global border colors.
        --b38: var(--darker-rgb);     /// Profile border colors.
        --ce3: var(--darker-rgb);     /// Post border colors.
        --ca6: var(--darker-rgb);     /// Login border colors.
        --d87: var(--darken-rgb);     /// Highlighted background.
        --f23: var(--darken-rgb);     /// 'New Posts' button.
        --b3f: var(--dark-rgb);       /// Primary background.
        --i1d: var(--light-rgb);      /// Main text color.
        --f75: var(--light-rgb);      /// Primary text.
        --f52: var(--lighter-rgb);    /// Secondary text.
        --bb2: var(--darken-rgb);     /// Post placeholder.
        --f23: var(--dark-rgb);       /// Dialogs.
        --fe0: var(--accent-rgb);     /// Links.
        --d69: var(--accent-rgb);     /// Post/login button.
        --c37: var(--accent-rgb);     /// Notifications.
        --eca: var(--darken-rgb);     /// New feature alert.
        --jb7: var(--shadow-rgb);     /// Emoji menu shadow.
        --fa7: var(--darken-rgb);     /// New message user.
        --de5: var(--white-rgb);      /// Badge text color.
    }

    /// Feat -> Scrollbars.
    /{
        /// Width.
        if (sb_width) {
            ::-webkit-scrollbar { width: 0.5em }
            * { scrollbar-width: thin }
        }

        /// Colors.
        if (sb_color == 'old') {
            html { scrollbar-color: #88888840 #88888815 }
            ::-webkit-scrollbar {
                c: 0 0 #88888815;
                &-thumb { c: 0 0 #88888840 }
            }
        } else if (sb_color == 'new') {
            html { scrollbar-color: var(--accent) #88888815 }
            ::-webkit-scrollbar {
                c: 0 0 #88888815;
                &-thumb { c: 0 0 var(--accent) }
            }
        }
    }

    // Overwrite existing Stylus-lang vars with CSS vars.
    bg      = var(--dark);
    hl      = var(--darken);
    bd      = var(--darker);
    fg      = var(--light);
    cm      = var(--lighter);
    ac      = var(--accent);
    sh      = var(--shadow);
    bsh     = var(--bshadow);
    yellow  = var(--yellow);
    orange  = var(--orange);
    red     = var(--red);
    magenta = var(--magenta);
    violet  = var(--violet);
    blue    = var(--blue);
    cyan    = var(--cyan);
    green   = var(--green);
    white   = var(--white);
    t       = var(--t);
    outer   = 0 0 0 1px bd;
    inner   = inset outer;

    /// Loader animation.
    @keyframes Loader {
          0% { background-position: 33%   0% }
         50% { background-position: 68% 100% }
        100% { background-position: 33%   0% }
    }

    // App styles.
    body {
        c: fg 0 bg;

        ::placeholder { c: cm }
        ::-webkit-input-placeholder { c: cm }

        /// Feat -> Custom UI font.
        &, button, input, textarea {
            font-family: var(--ui-font) i;
        }

        /// Loading.
        &[style *= 'background: white'] {
            c: 0 0 bg;
            svg { fill: cm i }
        }

        /// 404 page.
        &[class *= 'error'], &[class *= '404'] {
            .top-bar {
                c: fg bd hl;
                if (ic_invert) {
                    .logo { filter: invert(0.8) i }
                }
            }
            a, strong { c: ac }
        }

        /// Icons.
        svg {
            &[fill = '#262626'] { fill: fg }
            &[fill = '#ffffff'] { fill: fg }
            &[fill = '#8e8e8e'] { fill: cm }
            &[fill = '#ed4956'] { fill: red }
            &[fill = '#0095f6'] { fill: blue }
            path {
                transition: fill-opacity 0.2s ease;
                ../:hover path { fill-opacity: 0.6 }
            }
        }

        /// Feat -> Icon inversion in dark mode.
        if (ic_invert) {
            .coreSprite {
                &LoggedOutWordmark,
                &MobileNavDirect,
                &TaggedNull {
                    filter: invert(0.8) i;
                }
                /// Modals -> Share menu.
                /[class *= 'SpriteDirect'],
                /[class *= 'SpriteFacebook'],
                /[class *= 'SpriteLink'],
                /[class *= 'SpriteMail'],
                /[class *= 'SpriteApp'],
                /[class *= 'Spritez'],
                /// Login -> Save login info.
                /[class *= 'SpriteKeyhole'],
                /// Profile -> Private.
                /[class *= 'SpriteLock_'],
                /// Profile -> Follow.
                /[class *= 'SpriteFriend_'],
                /// Profile -> Followers.
                /[class *= 'SpriteAdd_friend_'],
                /// Profile -> Options.
                /[class *= 'SpriteDropdownArrowGrey'],
                /// Profile -> Suggestions.
                /[class *= 'SpritePagingChevron'],
                /// Profile -> No posts.
                /[class *= 'SpriteCamera'],
                /// Profile -> IGTV icon.
                /[class *= 'SpriteProfileChannelNullState'],
                /// Settings -> Login activity.
                /[class *= 'SpriteLocation_'],
                /// Expore -> Leaflet info icon.
                /[class *= 'SpriteInfo__filled__16__grey'],
                /// Posts -> Load more messages.
                /[class *= 'SpriteCircle_add'] {
                    filter: invert(0.8) i;
                }
            }
            /// Default profile.
            /img[src *= '44884218_345707102882519_2446069589734326272'] {
                filter: invert(0.8) i;
            }
        }

        /// Login -> Links.
        ._2Lks6 { c: ac }

        /// Navbar -> Invert IG logo.
        if (ic_invert) {
            nav a[href = '/'] img {
                &, /[src *= 'logo.png'] { filter: invert(0.8) }
            }
        }

        /// Navbar -> Followers.
        .HZ802, .nHGTw {
            c: white 0 ac;
            .H9zXO::after { c: 0 0 ac }
            /.iMofo { box-shadow: 0 4px 16px sh i }
            [class *= 'Sprite'] + div > div { c: white }
        }

        /// Modals -> Tweak backdrop color.
        > [role = 'presentation'], > [role = 'dialog'] {
            background: unquote('rgba(var(--b3f), 0.8)') i;
        }

        /// Feat -> Remove logged-out annoyances.
        if (enable_la) {
            /.not-logged-in {
                /// Remove login/signup bar.
                .N9d2H { display: none i }
                /// Remove login/signup prompt.
                [style *= 'overflow: hidden'] {
                    overflow: unset i;
                    > [role = 'presentation'] { display: none i }
                }
            }
        }

        /// Search -> Hashtags | Sections.
        .LFGs8 { c: ac }
        .yQ0j1 { c: cm }

        /// Profile -> Avatar background.
        .M-jxE { &, > button { c: 0 0 hl }}

        /// Profile -> Private account alert.
        ._4Kbb_ {
            margin-top: 1rem;
            c: fg bd hl;
            /.hUQXy { &, &:visited { c: ac }}
        }

        /// Profile -> Empty profile alert.
        .jju9v {
            border: 1px solid bd;
            c: fg 0 hl;
        }

        /// Profile -> Following -> Hashtags.
        .hI7cq { c: fg }

        /// Profile -> Following -> List background.
        .isgrP > ul { c: 0 0 t }

        /// Settings -> Links.
        ._7LpC8 a, .rin8p { c: ac }

        /// Settings -> Fix borders | Profile -> Camera | Hashtags.
        .rb9ad, .-wdIA, .d-Vzv { c: 0 bd }

        /// Global -> Leaflet.
        .leaflet {
            /// Explore -> Locations.
            &-container {
                c: 0 0 hl;
                box-shadow: 0 1px bd;
                /// Invert map tiles.
                ../-tile { filter: invert(0.9) hue-rotate(180deg) i }
            }
            /// Settings -> Login activity.
            &-popup {
                &-content-wrapper, &-tip {
                    c: 0 0 hl;
                    box-shadow: 0 3px 14px sh;
                }
            }
        }

        /// Stories -> Reset 'Send message' area.
        .Sux9m {
            c: 0 #aaa #eee1
            --eca: var(--light-rgb)
            ::placeholder { c: #eee }
            ::-webkit-input-placeholder { c: #eee }
            + div [class*='glyphsSpriteDirect_'] { filter: invert(0.3) i }
        }

        /// Posts -> 'New Posts' button.
        .tCibT {
            border: 1px solid bd i;
            box-shadow: bsh i;
        }

        /// Posts -> 'Video has no sound' alert.
        /.R8iOs {
            border: 1px solid bd i
            c: fg 0 bg
            > * { color: inherit }

            /// Posts -> (Un)mute / Tagged button.
            /[role='button'] + span[class=''] > div[class], /.G_hoz { c: 0 0 bd }
        }

        /// Profile/Posts -> Related accounts.
        header + div, article + div {
            + div.GZkEI {
                /// Suggested accounts.
                li[style] > div > div > [role] { --d87: var(--dark-rgb) }
            }
        }

        /// Posts -> Invert loading image.
        if (ic_invert) {
            .WidCF, .HaS-3 {
                border-right: 1px solid bd;
                background-size: 200% 200% i;
                background: linear-gradient(115deg, bg 40%, hl, bg 60%);
                animation: Loader 2.5s ease infinite i;
                c: 0 0 hl;
            }
        }

        /// Posts -> Lightbox borders.
        [role = 'dialog'] {
            /body > ^[1..1] > ^[1..1] > ^[1..1] {
                border: 1px solid bd i;
                box-shadow: 0 0px 16px hl;
            }
            > article > header {
                overflow-x: hidden i;
                /// Post area background.
                + div { --jb7: var(--darken-rgb) }
            }
        }

        /// Posts -> Context menu borders.
        > [role = 'presentation'] {
            > [role = 'dialog'] > div { border: 1px solid bd i }
            /// Hover styles.
            button.aOOlW:not(.SRPMb) {
                &:hover, &:active { c: 0 0 hl }
            }
        }

        /// Posts -> Post pagination.
        article > header ~ div .WXPwG .Yi5aA { c: 0 0 white }

        /// Feat -> Enable right-click context menu in stories.
        if (enable_cm_s) {
            img, video {
                + div[style = 'height: 100%;'] {
                    position: unset i;
                    display: none i;
                }
            }
        }

        /// Feat -> Enable right-click context menu in posts.
        if (enable_cm_p) {
            /// Posts -> Images.
            ._9AhH0 { position: unset i }
            /// Posts -> Videos.
            /// NOTE: This will allow you to right-click on the bottom 40px.
            .PyenC, .fXIG0 { bottom: 40px i }
        }

        /// Page -> Profiles directory.
        .GBPOY {
            rad: 3px;
            c: 0 bd hl;
            a { c: fg }
        }

        /// DMs -> Emoji menu.
        .uo5MA {
            &, > div:nth-child(1) {
                box-shadow: bsh i;
                border: 1px solid bd;
                c: 0 0 bg;
            }
            > div:nth-child(2) { c: 0 0 bg }
            > div:nth-child(3) { rad: 0 0 6px 6px }
            /// Navbar -> Follower suggestions.
            .DPiy6 { c: 0 0 t }
        }

        /// DMs -> Active chat.
        .QOqBd { c: 0 0 #8881 }

        /// DMs -> Input bar.
        /.X3a-9 { c: 0 0 bg }

        /// DMs -> Message bubbles.
        .CMoMH {
            &:not(._6FEQj) { c: 0 0 bg }
            &._6FEQj { c: 0 0 bd }
        }

        /// DMs -> Context menu items.
        [role='listbox'] [aria-hidden='false'] > {
            [style*='left: calc('] + div {
                --eca: var(--white-rgb) i
            }
        }

        /// Footer -> Sent message.
        .XjicZ {
            border-top: 1px solid bd;
            c: 0 0 hl;
            p { c: fg }
        }

        /// Footer.
        footer {
            width: 100% i
            margin: 0 auto i
            max-width: 935px i
            border-top: 1px solid bd i

            /// Settings -> Add whitespace between sections.
            /.XfvCs { margin-bottom: 30px i }

            /// Add userstyle information.
            > div::after {
                content: var(--note)
                white-space: pre-wrap
                text-align: center
                margin-top: 2rem
            }
        }
    }
