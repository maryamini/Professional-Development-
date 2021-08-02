 % Clear the workspace and the screen

sca;
close all;
clearvars;
debug=0;
Screen('Preference', 'SkipSyncTests', 1); 
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% debug mode
%% EXERCISE 1: change debug = 0; debug = 1;
% See what happens
%% EXERCISE 2:  What does ListenChar(2) vs ListenChar(0) do?
if debug
    ListenChar(0);
    PsychDebugWindowConfiguration;
else
    ListenChar(2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HideCursor;
% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Setup the text type for the window
Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 36);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Here we set the size of the arms of our fixation cross
fixCrossDimPix = 40;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 4;

% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
Screen('DrawLines', window, allCoords,...
    lineWidthPix, white, [xCenter yCenter], 2);

% Flip to the screen
Screen('Flip', window);

% Wait for a key press

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% get keyboard device 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[id, name]                     = GetKeyboardIndices;
trigger_index                  = find(contains(name, 'Apple Internal Keyboard / Trackpad'));
trigger_inputDevice            = id(trigger_index);

DisableKeysForKbCheck([]);
KbTriggerWait(KbName('5%'), trigger_inputDevice);

%%%%%%%%%%%%%%%%
ListenChar(0);
%% EXERCISE 3: Why is this necessary? 
%%%%%%%%%%%%%%%%

% Clear the screen
sca;

function WaitKeyPress(kID)
        while KbCheck(-3); end  % Wait until all keys are released.
        while 1
            % Check the state of the keyboard.
            [ keyIsDown, ~, keyCode ] = KbCheck(-3);
            % If the user is pressing a key, then display its code number and name.
            if keyIsDown
                if keyCode(p.keys.esc)
                    cleanup; break;
                elseif keyCode(kID)
                    break;
                end
                % make sure key is released
                while KbCheck(-3); end
            end
        end
    end
