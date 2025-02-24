
function [bearing, distance] = bearing(lat1, lon1, lat2, lon2)
    delta_lon = lon2 - lon1;
    x = cos(lat2) * sin(delta_lon);
    y = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(delta_lon);
    bearing = atan2(x, y);
    distance = haversine(lat1, lon1, lat2, lon2, 6371000);
end
function d = haversine(lat1, lon1, lat2, lon2, R)
    dlat = lat2 - lat1;
    dlon = lon2 - lon1;
    a = sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1 - a));
    d = R * c;
end
road_width = 100; 
ideal_trajectory = [];
left_road_trajectory = []; % Left boundary of the road
right_road_trajectory = []; % Right boundary of the road
% Example coordinates for the track (latitude, longitude)
coordinates = [
    51.449681, 25.489077; 51.448139, 25.491625; 51.447534, 25.492614;
    51.447494, 25.492799; 51.447520, 25.492991; 51.447597, 25.493140;
    51.447718, 25.493249; 51.447904, 25.493348; 51.448117, 25.493378;
    51.448318, 25.493345; 51.449857, 25.492502; 51.450004, 25.492465;
    51.450198, 25.492459; 51.450421, 25.492518; 51.450601, 25.492670;
    51.450704, 25.492836; 51.450729, 25.493004; 51.450694, 25.494215;
    51.450716, 25.494380; 51.450771, 25.494522; 51.450845, 25.494658;
    51.450951, 25.494770; 51.453146, 25.496966; 51.453267, 25.497055;
    51.453454, 25.497102; 51.453634, 25.497115; 51.453817, 25.497072;
    51.453960, 25.496996; 51.454612, 25.496434; 51.454685, 25.496315;
    51.454718, 25.496152; 51.454711, 25.496010; 51.454667, 25.495871;
    51.454572, 25.495746; 51.453146, 25.494332; 51.453084, 25.494229;
    51.453080, 25.494117; 51.453113, 25.494018; 51.453183, 25.493945;
    51.453286, 25.493886; 51.453428, 25.493869; 51.453527, 25.493895;
    51.453656, 25.493948; 51.456147, 25.494848; 51.456310, 25.494864;
    51.456511, 25.494838; 51.456680, 25.494769; 51.456812, 25.494649;
    51.456893, 25.494497; 51.456925, 25.494347; 51.456922, 25.494215;
    51.456874, 25.494089; 51.456772, 25.493943; 51.456687, 25.493871;
    51.456493, 25.493728; 51.456277, 25.493504; 51.456097, 25.493279;
    51.455947, 25.493039; 51.455826, 25.492758; 51.455757, 25.492566;
    51.455683, 25.492229; 51.455621, 25.492085; 51.455515, 25.491963;
    51.455401, 25.491886; 51.455248, 25.491824; 51.453832, 25.491513;
    51.453708, 25.491447; 51.453613, 25.491371; 51.453558, 25.491245;
    51.453536, 25.491123; 51.453561, 25.490939; 51.453715, 25.490757;
    51.453979, 25.490516; 51.454386, 25.490236; 51.454811, 25.490018;
    51.455243, 25.489879; 51.455675, 25.489796; 51.456097, 25.489763;
    51.456558, 25.489803; 51.458674, 25.490015; 51.458868, 25.489978;
    51.459092, 25.489882; 51.459264, 25.489763; 51.459425, 25.489565;
    51.459916, 25.488741; 51.459956, 25.488599; 51.459956, 25.488470;
    51.459934, 25.488335; 51.459832, 25.488163; 51.459070, 25.487053;
    51.458974, 25.486970; 51.458832, 25.486911; 51.458685, 25.486871;
    51.458487, 25.486878; 51.456054, 25.487321; 51.455881, 25.487321;
    51.455709, 25.487275; 51.455563, 25.487185; 51.455460, 25.487070;
    51.453766, 25.484096; 51.453630, 25.483954; 51.453476, 25.483868;
    51.453253, 25.483835; 51.453084, 25.483852; 51.452919, 25.483915;
    51.452751, 25.484047; 51.449681, 25.489077 % Closing the loop
];
% Initialize figure for animation
figure;
hold on;
axis equal;
grid on;
title('Car Animation on Ideal Trajectory');
xlabel('Longitude');
ylabel('Latitude');
% Plot the original track
plot(coordinates(:,2), coordinates(:,1), '-o', 'Color', 'b', 'LineWidth', 5);
% Initialize the car marker (using a small circle for the car)
car_marker = plot(NaN, NaN, 'ro', 'MarkerFaceColor', 'r');
% Initialize car position variable
car_pos = 1; % Start at the first point
% Loop through the coordinates to calculate the ideal trajectory and animate the car's movement
for i = 2:size(coordinates, 1)-1
    % Get consecutive points to define the segment and turn radius
    lat1 = deg2rad(coordinates(i-1,1));
    lon1 = deg2rad(coordinates(i-1,2));
    lat2 = deg2rad(coordinates(i,1));
    lon2 = deg2rad(coordinates(i,2));
    lat3 = deg2rad(coordinates(i+1,1));
    lon3 = deg2rad(coordinates(i+1,2));
    % Calculate distances for curvature radius
    [bearing1, ~] = bearing(lat1, lon1, lat2, lon2);
    [bearing2, ~] = bearing(lat2, lon2, lat3, lon3);
    % Add the point to the ideal trajectory if there's a significant change in direction
    if abs(bearing1 - bearing2) > 0.1
        ideal_trajectory = [ideal_trajectory; coordinates(i, :)];
    end
end
% Plot the ideal trajectory
plot(ideal_trajectory(:, 2), ideal_trajectory(:, 1), '-g', 'LineWidth', 1);
% Animate the car
for i = 1:length(ideal_trajectory)
    % Update the car's position
    set(car_marker, 'XData', ideal_trajectory(i, 2), 'YData', ideal_trajectory(i, 1));
    
    % Pause for animation effect
    pause(0.1);
end