% Width of the road (in meters)
road_width = 50; % Adjust as needed

% Initialize matrix for storing ideal trajectory points
ideal_trajectory = [];
left_road_trajectory = []; % Left boundary of the road
right_road_trajectory = []; % Right boundary of the road

for i = 2:size(coordinates, 1)-1
    % Get consecutive points to define the segment and turn radius
    lat1 = deg2rad(coordinates(i-1,1));
    lon1 = deg2rad(coordinates(i-1,2));
    lat2 = deg2rad(coordinates(i,1));
    lon2 = deg2rad(coordinates(i,2));
    lat3 = deg2rad(coordinates(i+1,1));
    lon3 = deg2rad(coordinates(i+1,2));

    % Calculate distances for curvature radius
    d12 = haversine(lat1, lon1, lat2, lon2, R);
    d23 = haversine(lat2, lon2, lat3, lon3, R);
    d13 = haversine(lat1, lon1, lat3, lon3, R);

    s = (d12 + d23 + d13) / 2;
    area = sqrt(s * (s - d12) * (s - d23) * (s - d13));
    radius = (d12 * d23 * d13) / (4 * area);

    % Ideal point offset calculation based on turn radius
    offset_distance = road_width / 2; % half the road width
    lat_offset = offset_distance / R;
    lon_offset = offset_distance / (R * cos(lat2));

    % Shift ideal trajectory inward or outward for optimal turning
    if radius > 0
        ideal_lat = lat2 - lat_offset;
        ideal_lon = lon2 - lon_offset;
    else
        ideal_lat = lat2 + lat_offset;
        ideal_lon = lon2 + lon_offset;
    end

    % Store the ideal trajectory point
    ideal_trajectory = [ideal_trajectory; rad2deg(ideal_lat), rad2deg(ideal_lon)];

    % Calculate left and right boundaries for the road
    left_lat = lat2 + lat_offset * cos(bearing(lat2, lon2, lat1, lon1));  % Left boundary
    left_lon = lon2 + lon_offset * sin(bearing(lat2, lon2, lat1, lon1));

    right_lat = lat2 - lat_offset * cos(bearing(lat2, lon2, lat1, lon1)); % Right boundary
    right_lon = lon2 - lon_offset * sin(bearing(lat2, lon2, lat1, lon1));

    % Store left and right road boundary points
    left_road_trajectory = [left_road_trajectory; rad2deg(left_lat), rad2deg(left_lon)];
    right_road_trajectory = [right_road_trajectory; rad2deg(right_lat), rad2deg(right_lon)];
end

% Plot the track and ideal trajectory
figure;
hold on;
axis equal;
grid on;
title('Ордабасы чемпион');
xlabel('Longitude');
ylabel('Latitude');

% Original track
plot(coordinates(:,2), coordinates(:,1), '-o', 'Color', 'b', 'LineWidth', 2);

% Ideal trajectory
plot(ideal_trajectory(:,2), ideal_trajectory(:,1), '-x', 'Color', 'g', 'LineWidth', 1.5);

% Road boundaries (left and right)
plot(left_road_trajectory(:,2), left_road_trajectory(:,1), '--b', 'LineWidth', 14);  % Left boundary (blue)
plot(right_road_trajectory(:,2), right_road_trajectory(:,1), '--b', 'LineWidth', 14); % Right boundary (blue)

% Mark radii on the turns
for i = 2:size(coordinates,1)-1
    text(coordinates(i,2), coordinates(i,1), sprintf('R=%.2f m', radius), 'Color', 'r', 'FontSize', 8);
end

hold off;

% Function to calculate the bearing between two points
function [bearing, distance] = bearing(lat1, lon1, lat2, lon2)
    delta_lon = lon2 - lon1;
    x = cos(lat2) * sin(delta_lon);
    y = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(delta_lon);
    bearing = atan2(x, y);
    distance = haversine(lat1, lon1, lat2, lon2, 6371000);
end

% Function to calculate Haversine distance
function d = haversine(lat1, lon1, lat2, lon2, R)
    dlat = lat2 - lat1;
    dlon = lon2 - lon1;
    a = sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1 - a));
    d = R * c;
end
